#!/usr/bin/env bash
# Launch Centos/RHEL 7 VM with at least 8 vcpu / 32Gb+ memory / 100Gb disk
# https://gist.github.com/abajwa-hw/66c62bc860a47dfb0de53dfe5cbb4415

export create_image=false
export ambari_version=2.7.1.0
export mpack_url="http://public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.3.0.0/tars/hdf_ambari_mp/hdf-ambari-mpack-3.3.0.0-165.tar.gz"
export hdf_vdf="http://s3.amazonaws.com/public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.3.0.0/HDF-3.3.0.0-165.xml"

export bp_template="https://gist.github.com/abajwa-hw/691d1e97b5b61c5be7ec4acb383d0de4/raw"

export ambari_password=${ambari_password:-StrongPassword}
export db_password=${db_password:-StrongPassword}
export nifi_flow="https://gist.githubusercontent.com/abajwa-hw/3857a205d739473bb541490f6471cdba/raw"
export install_solr=false
export host=$(hostname -f)

export ambari_services="HDFS MAPREDUCE2 YARN ZOOKEEPER HIVE SPARK ZEPPELIN"
export cluster_name=princeton
export ambari_stack_version=3.0
export host_count=1

#service user for Ambari to setup demos
export service_user="demokitadmin"
export service_password="BadPass#1"

if [ "${create_image}" = true  ]; then
  echo "updating /etc/hosts with demo.hortonworks.com entry pointing to VMs ip, hostname..."
  curl -sSL https://gist.github.com/abajwa-hw/9d7d06b8d0abf705ae311393d2ecdeec/raw | sudo -E sh
  sleep 5
fi

export host=$(hostname -f)
echo "Hostname is: ${host}"

echo Installing Packages...
sudo yum localinstall -y https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm
sudo yum install -y git python-argparse epel-release mysql-connector-java* mysql-community-server nc
# MySQL Setup to keep the new services separate from the originals
echo Database setup...
sudo systemctl enable mysqld.service
sudo systemctl start mysqld.service
#extract system generated Mysql password
oldpass=$( grep 'temporary.*root@localhost' /var/log/mysqld.log | tail -n 1 | sed 's/.*root@localhost: //' )
#create sql file that
# 1. reset Mysql password to temp value and create druid/superset/registry/streamline schemas and users
# 2. sets passwords for druid/superset/registry/streamline users to ${db_password}
cat << EOF > mysql-setup.sql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Secur1ty!';
uninstall plugin validate_password;
commit;
EOF
#execute sql file
mysql -h localhost -u root -p"$oldpass" --connect-expired-password < mysql-setup.sql
#change Mysql password to ${db_password}
mysqladmin -u root -p'Secur1ty!' password ${db_password}
#test password and confirm dbs created
mysql -u root -p${db_password} -e 'show databases;'
# Install Ambari
echo Installing Ambari

export install_ambari_server=true
#export java_provider=oracle
curl -sSL https://raw.githubusercontent.com/abajwa-hw/ambari-bootstrap/master/ambari-bootstrap.sh | sudo -E sh
sudo ambari-server setup --jdbc-db=mysql --jdbc-driver=/usr/share/java/mysql-connector-java.jar
sudo ambari-server install-mpack --verbose --mpack=${mpack_url}
# Hack to fix a current bug in Ambari Blueprints
sudo sed -i.bak "s/\(^    total_sinks_count = \)0$/\11/" /var/lib/ambari-server/resources/stacks/HDP/2.0.6/services/stack_advisor.py

#echo "Creating Storm View..."
#curl -u admin:admin -H "X-Requested-By:ambari" -X POST -d '{"ViewInstanceInfo":{"instance_name":"Storm_View","label":"Storm View","visible":true,"icon_path":"","icon64_path":"","description":"storm view","properties":{"storm.host":"'${host}'","storm.port":"8744","storm.sslEnabled":"false"},"cluster_type":"NONE"}}' http://${host}:8080/api/v1/views/Storm_Monitoring/versions/0.1.0/instances/Storm_View

#create demokitadmin user
curl -iv -u admin:admin -H "X-Requested-By: blah" -X POST -d "{\"Users/user_name\":\"${service_user}\",\"Users/password\":\"${service_password}\",\"Users/active\":\"true\",\"Users/admin\":\"true\"}" http://localhost:8080/api/v1/users

echo "Updating admin password..."
curl -iv -u admin:admin -H "X-Requested-By: blah" -X PUT -d "{ \"Users\": { \"user_name\": \"admin\", \"old_password\": \"admin\", \"password\": \"${ambari_password}\" }}" http://localhost:8080/api/v1/users/admin

cd /tmp


sudo ambari-server restart

tee /tmp/repo.json > /dev/null << EOF
{
  "Repositories": {
    "base_url": "http://public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.3.0.0",
    "verify_base_url": true,
    "repo_name": "HDF"
  }
}
EOF

curl -v -k -u admin:${ambari_password} -H "X-Requested-By:ambari" -X POST http://localhost:8080/api/v1/version_definitions -d @- <<EOF
{  "VersionDefinition": {   "version_url": "${hdf_vdf}" } }
EOF

#wget ${hdf_repo} -P /etc/yum.repos.d/

sudo ambari-server restart

# Ambari blueprint cluster install
echo "Deploying HDP and HDF services..."
curl -ssLO https://github.com/seanorama/ambari-bootstrap/archive/master.zip
unzip -q master.zip -d  /tmp

export host=$(hostname -f)
cd /tmp
echo "downloading twitter flow..."
twitter_flow=$(curl -L ${nifi_flow})
#change kafka broker string for Ambari to replace later
twitter_flow=$(echo ${twitter_flow}  | sed "s/demo.hortonworks.com/${host}/g")
nifi_config="\"nifi-flow-env\" : { \"properties_attributes\" : { }, \"properties\" : { \"content\" : \"${twitter_flow}\"  }  },"
echo ${nifi_config} > nifi-config.json


echo "downloading Blueprint configs template..."
curl -sSL ${bp_template} > configuration-custom-template.json

echo "adding Nifi flow to blueprint configs template..."
sed -e "2r nifi-config.json" configuration-custom-template.json  > configuration-custom.json


if [ "${create_image}" = true  ]; then
  echo "Setting up auto start of services on boot"
  curl -sSL https://gist.github.com/abajwa-hw/408134e032c05d5ff7e592cd0770d702/raw | sudo -E sh
fi


cd /tmp/ambari-bootstrap-master/deploy
sudo cp /tmp/configuration-custom.json .

#export deploy=false

# This command might fail with 'resources' error, means Ambari isn't ready yet
echo "Waiting for 90s before deploying cluster with services: ${ambari_services}"
sleep 90
sudo -E /tmp/ambari-bootstrap-master/deploy/deploy-recommended-cluster.bash


echo Now open your browser to http://$(curl -s icanhazptr.com):8080 and login as admin/${ambari_password} to observe the cluster install

echo "Waiting for cluster to be installed..."
sleep 5

#wait until cluster deployed
ambari_pass="${ambari_password}" source /tmp/ambari-bootstrap-master/extras/ambari_functions.sh
ambari_configs
ambari_wait_request_complete 1

sleep 10
