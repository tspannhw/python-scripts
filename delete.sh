yum remove hive\* -y
yum remove nifi\* -y
yum remove oozie\* -y
yum remove pig\* -y
yum remove zookeeper\* -y
yum remove tez\* -y
yum remove hbase\* -y
yum remove ranger\* -y
yum remove knox\* -y
yum remove storm\* -y
yum remove accumulo\* -y
yum remove falcon\* -y
yum remove ambari-metrics-hadoop-sink
yum remove smartsense-hst -y
yum remove slider_2_4_2_0_258 -y
yum remove ambari-metrics-monitor -y
yum remove spark2_2_5_3_0_37-yarn-shuffle -y
yum remove spark_2_5_3_0_37-yarn-shuffle -y
yum remove ambari-infra-solr-client -y
kill -KILL `ps aux | grep hdp | awk '{ print $2 }'`
kill -KILL `ps aux | grep hadoop | awk '{ print $2 }'`
python /usr/lib/python2.6/site-packages/ambari_agent/HostCleanup.py -h

ambari-server stop
ambari-server reset
ambari-agent stop
service mysqld stop
service postgresql stop

###################33REMOVE HORTONWORKS - UNINSTALL
userdel -r infra-solr
userdel -r livy
userdel -r accumulo
userdel -r ambari-qa
userdel -r ams
userdel -r falcon
userdel -r flume
userdel -r hbase
userdel -r hcat
userdel -r hdfs
userdel -r hive
userdel -r kafka
userdel -r knox
userdel -r mapred
userdel -r oozie
userdel -r ranger
userdel -r spark
userdel -r sqoop
userdel -r storm
userdel -r tez
userdel -r yarn
userdel -r zeppelin
userdel -r zookeeper
userdel -r activity_analyzer
userdel -r atlas
userdel -r mahout

python /usr/lib/python2.6/site-packages/ambari_agent/HostCleanup.py

yum erase -y `yum list | grep @HDP-3 | awk '{ print $1 }'`
yum erase -y `yum list | grep 3_ | awk '{ print $1 }'`
yum remove ambari\* hadoop hdfs bigtop-jsvc bigtop-tomcat hbase\* hadoop\* hdp-select ranger\* zookeeper\* postgresql-libs postgresql postgresql-server -y
yum remove mysql mysql-server mysql-libs mysql-connector-java -y

yum remove hive\* -y
yum remove oozie\* -y
yum remove pig\* -y
yum remove zookeeper\* -y
yum remove tez\* -y
yum remove hbase\* -y
yum remove ranger\* -y
yum remove knox\* -y
yum remove storm\* -y
yum remove accumulo\* -y

ambari-server stop
ambari-agent stop
yum erase ambari-server -y
yum erase ambari-agent -y

rm -rf /var/log/ambari-agent
rm -rf /var/log/ambari-metrics-grafana
rm -rf /var/log/ambari-metrics-monitor
rm -rf /var/log/ambari-server/
rm -rf /var/log/falcon
rm -rf /var/log/flume
rm -rf /var/log/hadoop
rm -rf /var/log/hadoop-mapreduce
rm -rf /var/log/hadoop-yarn
rm -rf /var/log/hive
rm -rf /var/log/hive-hcatalog
rm -rf /var/log/hive2
rm -rf /var/log/hst
rm -rf /var/log/knox
rm -rf /var/log/oozie
rm -rf /var/log/solr
rm -rf /var/log/zookeeper

rm -rf /hadoop/*
rm -rf /hdfs/hadoop
rm -rf /hdfs/lost+found
rm -rf /hdfs/var
rm -rf /local/opt/hadoop
rm -rf /tmp/hadoop
rm -rf /usr/bin/hadoop
rm -rf /usr/hdp
rm -rf /var/hadoop
rm -rf /grid/hadoop

rm -rf /etc/ambari-agent
rm -rf /etc/ambari-metrics-grafana
rm -rf /etc/ambari-server
rm -rf /etc/ams-hbase
rm -rf /etc/falcon
rm -rf /etc/flume
rm -rf /etc/hadoop
rm -rf /etc/hadoop-httpfs
rm -rf /etc/hbase
rm -rf /etc/hive
rm -rf /etc/hive-hcatalog
rm -rf /etc/hive-webhcat
rm -rf /etc/hive2
rm -rf /etc/hst
rm -rf /etc/knox
rm -rf /etc/livy
rm -rf /etc/mahout
rm -rf /etc/oozie
rm -rf /etc/phoenix
rm -rf /etc/pig
rm -rf /etc/ranger-admin
rm -rf /etc/ranger-usersync
rm -rf /etc/spark2
rm -rf /etc/tez
rm -rf /etc/tez_hive2
rm -rf /etc/zookeeper


rm -rf /var/run/ambari-agent
rm -rf /var/run/ambari-metrics-grafana
rm -rf /var/run/ambari-server
rm -rf /var/run/falcon
rm -rf /var/run/flume
rm -rf /var/run/hadoop
rm -rf /var/run/hadoop-mapreduce
rm -rf /var/run/hadoop-yarn
rm -rf /var/run/hbase
rm -rf /var/run/hive
rm -rf /var/run/hive-hcatalog
rm -rf /var/run/hive2
rm -rf /var/run/hst
rm -rf /var/run/knox
rm -rf /var/run/oozie
rm -rf /var/run/webhcat
rm -rf /var/run/zookeeper

rm -rf /usr/lib/ambari-agent
rm -rf /usr/lib/ambari-infra-solr-client
rm -rf /usr/lib/ambari-metrics-hadoop-sink
rm -rf /usr/lib/ambari-metrics-kafka-sink
rm -rf /usr/lib/ambari-server-backups
rm -rf /usr/lib/ams-hbase
rm -rf /usr/lib/mysql
rm -rf /var/lib/ambari-agent
rm -rf /var/lib/ambari-metrics-grafana
rm -rf /var/lib/ambari-server
rm -rf /var/lib/smartsense/

yum remove mysql mysql-server -y
yum erase postgresql -y
rm -rf /var/lib/pgsql
rm -rf /var/lib/mysql


cd /usr/bin
rm -rf accumulo
rm -rf atlas-start
rm -rf atlas-stop
rm -rf beeline
rm -rf falcon
rm -rf flume-ng
rm -rf hbase
rm -rf hcat
rm -rf hdfs
rm -rf hive
rm -rf hiveserver2
rm -rf kafka
rm -rf mahout
rm -rf mapred
rm -rf oozie
rm -rf oozied.sh
rm -rf phoenix-psql
rm -rf phoenix-queryserver
rm -rf phoenix-sqlline
rm -rf phoenix-sqlline-thin
rm -rf pig
rm -rf python-wrap
rm -rf ranger-admin
rm -rf ranger-admin-start
rm -rf ranger-admin-stop
rm -rf ranger-kms
rm -rf ranger-usersync
rm -rf ranger-usersync-start
rm -rf ranger-usersync-stop
rm -rf slider
rm -rf sqoop
rm -rf sqoop-codegen
rm -rf sqoop-create-hive-table
rm -rf sqoop-eval
rm -rf sqoop-export
rm -rf sqoop-help
rm -rf sqoop-import
rm -rf sqoop-import-all-tables
rm -rf sqoop-job
rm -rf sqoop-list-databases
rm -rf sqoop-list-tables
rm -rf sqoop-merge
rm -rf sqoop-metastore
rm -rf sqoop-version
rm -rf storm
rm -rf storm-slider
rm -rf worker-lanucher
rm -rf yarn
rm -rf zookeeper-client
rm -rf zookeeper-server
rm -rf zookeeper-server-cleanup

rm -rf /etc/ambari-metrics-monitor
rm -rf /run/ambari-metrics-monitor
rm -rf /run/systemd/generator.late/ambari-agent.service
rm -rf /run/systemd/generator.late/runlevel5.target.wants/ambari-agent.service
rm -rf /run/systemd/generator.late/runlevel4.target.wants/ambari-agent.service
rm -rf /run/systemd/generator.late/runlevel3.target.wants/ambari-agent.service
rm -rf /run/systemd/generator.late/runlevel2.target.wants/ambari-agent.service
rm -rf /usr/sbin/ambari-metrics-monitor
rm -rf /usr/sbin/ambari-metrics-grafana
rm -rf /usr/lib/python2.6/site-packages/resource_monitoring/ambari_commons
rm -rf /usr/lib/python2.6/site-packages/resource_monitoring/ambari_commons/ambari_metrics_helper.py
rm -rf /usr/lib/python2.6/site-packages/resource_monitoring/ambari_commons/ambari_service.py
rm -rf /usr/lib/ambari-infra-solr
rm -rf /usr/lib/ambari-infra-solr/server/solr-webapp/webapp/WEB-INF/lib/ambari-infra-solr-plugin-2.5.1.0.159.jar
rm -rf /usr/lib/ambari-metrics-grafana
rm -rf /usr/lib/ambari-metrics-grafana/public/app/plugins/datasource/ambari-metrics
rm -rf /var/lib/yum/repos/x86_64/7Server/ambari-2.5.1.0
rm -rf /var/lib/yum/yumdb/a/048eebe37ba82d5edb6c6d1341df74db91a11247-ambari-infra-solr-client-2.5.1.0-159-noarch
rm -rf /var/lib/yum/yumdb/a/8cf1bd3978c17de178593d4504040dfae1cbd6aa-ambari-infra-solr-2.5.1.0-159-noarch
rm -rf /var/lib/yum/yumdb/a/8bebaee277a46c683e15c60c658803028a9873fa-ambari-metrics-monitor-2.5.1.0-159-x86_64
rm -rf /var/lib/yum/yumdb/a/3e73c290f9f34120a31149246e8a776607d9d01a-ambari-metrics-hadoop-sink-2.5.1.0-159-x86_64
rm -rf /var/lib/yum/yumdb/a/bcd3dcfcd02b35d872e65a8cd30186463a574a4e-ambari-metrics-grafana-2.5.1.0-159-x86_64
rm -rf /var/log/ambari-infra-solr-client
rm -rf /var/cache/yum/x86_64/7Server/ambari-2.5.0.3
rm -rf /var/cache/yum/x86_64/7Server/ambari-2.5.1.0
rm -rf /etc/rc.d/rc0.d/K20ambari-agent
rm -rf /etc/rc.d/rc1.d/K20ambari-agent
rm -rf /etc/rc.d/rc2.d/S95ambari-agent
rm -rf /etc/rc.d/rc3.d/S95ambari-agent
rm -rf /etc/rc.d/rc4.d/S95ambari-agent
rm -rf /etc/rc.d/rc5.d/S95ambari-agent
rm -rf /etc/rc.d/rc6.d/K20ambari-agent
rm -rf /tmp/ambari.properties.4
rm -rf /tmp/ambari.properties.7
rm -rf /tmp/ambari.properties.1
rm -rf /tmp/ambari.properties.3
rm -rf /tmp/ambari.properties.6
rm -rf /tmp/ambari.properties.8
rm -rf /tmp/ambari.properties.2
rm -rf /tmp/ambari.properties.5
rm -rf /usr/sbin/ambari_server_main.pyc
rm -rf /hw/hdp/share/hst/ambari-service
rm -rf /hw/hdp/share/hst/ambari-service/SMARTSENSE/package/files/view/smartsense-ambari-view-1.4.0.2.5.1.0-159.jar
rm -rf /hw/hdp/share/hst/hst-common/lib/ambari-views-1.7.0.0.jar
rm -rf /hw/ambari_server
rm -rf /hw/ambari-server

rm -rf /run/accumulo
rm -rf /usr/bin/accumulo
rm -rf /var/log/accumulo
rm -rf /etc/accumulo

rm -rf /usr/bin/atlas-start
rm -rf /usr/bin/atlas-stop
rm -rf /var/lib/yum/yumdb/a/29f610c61af969f525f86f4378a0f4253e6f7b7f-atlas-metadata_2_6_1_0_129-falcon-plugin-0.8.0.2.6.1.0-129-noarch
rm -rf /var/lib/yum/yumdb/a/c0df10c33d2d232d1be32e3c33fb75ef6fdf3d54-atlas-metadata_2_6_1_0_129-hive-plugin-0.8.0.2.6.1.0-129-noarch
rm -rf /var/cache/yum/x86_64/7Server/HDP-2.6/packages/atlas-metadata_2_6_1_0_129-falcon-plugin-0.8.0.2.6.1.0-129.noarch.rpm
rm -rf /var/cache/yum/x86_64/7Server/HDP-2.6/packages/atlas-metadata_2_6_1_0_129-storm-plugin-0.8.0.2.6.1.0-129.noarch.rpm
rm -rf /etc/atlas
rm -rf /etc/storm

rm -rf /usr/bin/beeline

rm -rf /run/hadoop-hdfs
rm -rf /var/lib/hadoop-hdfs
rm -rf /var/lib/hadoop-yarn
rm -rf /var/lib/hadoop-mapreduce
rm -rf /var/log/hadoop-hdfs
rm -rf /hadoop

rm -rf /tmp/hbase-hbase
rm -rf /usr/bin/hbase
rm -rf /usr/share/kde4/services/plasma-runner-techbase.desktop
rm -rf /usr/share/kde4/services/searchproviders/kde_techbase.desktop
rm -rf /var/log/hbase

rm -rf /usr/bin/hcat
rm -rf /var/cache/yum/x86_64/7Server/HDP-2.6/packages/oozie_2_6_1_0_129-sharelib-hcatalog-4.2.0.2.6.1.0-129.noarch.rpm

rm -rf /usr/bin/hdfs
rm -rf /etc/security/limits.d/hdfs.conf

rm -rf /etc/kafka
rm -rf /var/run/storm
rm -rf /var/run/kafka
rm -rf /var/run/spark
rm -rf /var/log/storm
rm -rf /var/log/kafka
rm -rf /var/log/spark
rm -rf /var/lib/zookeeper
rm -rf /var/lib/knox
rm -rf /var/lib/hive
rm -rf /tmp/ambari-qa
rm -rf /var/lib/flume

rm -rf /etc/yum.repos.d/HDP*.repo
yum clean all

#find installation leftovers
find / -name *ambari*
find / -name *accumulo*
find / -name *atlas*
find / -name *beeline*
find / -name *falcon*
find / -name *flume*
find / -name *hadoop*
find / -name *hbase*
find / -name *hcat*
find / -name *hdfs*
