#!/usr/bin/env bash
# Launch Centos/RHEL 7 VM with at least 8 vcpu / 32Gb+ memory / 100Gb disk

export create_image=false
export ambari_version=2.7.1.0
export mpack_url="http://public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.3.0.0/tars/hdf_ambari_mp/hdf-ambari-mpack-3.3.0.0-165.tar.gz"
export hdf_vdf="http://s3.amazonaws.com/public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.3.0.0/HDF-3.3.0.0-165.xml"
export bp_template="https://gist.github.com/abajwa-hw/691d1e97b5b61c5be7ec4acb383d0de4/raw"
export ambari_password=admin
export db_password=Hadoop#321!
export nifi_flow="https://gist.githubusercontent.com/abajwa-hw/3857a205d739473bb541490f6471cdba/raw"
export install_solr=false    ## for Twitter demo
export host=$(hostname -f)
export ambari_services="HDFS MAPREDUCE2 YARN ZOOKEEPER HIVE NIFI NIFI_REGISTRY KAFKA REGISTRY HBASE PHOENIX ZEPPELIN"
export cluster_name=princeton
export ambari_stack_version=3.0
export host_count=1

#service user for Ambari to setup demos
export service_user="demokitadmin"
export service_password="BadPass#1"

export host=$(hostname -f)
echo "Hostname is: ${host}"


cd /opt/demo

# scp nifi-postimage-nar-1.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-twitter-nar-1.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-corenlp-nar-1.6.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-audio-nar-0.0.1-SNAPSHOT.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp haarcascade_frontalface_default.xml centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp haarcascade_lefteye_2splits.xml centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp haarcascade_righteye_2splits.xml centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp en-ner-percentage.bin centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp en-chunker.bin centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp en-ner-date.bin centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp en-parser-chunking.bin centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp en-ner-person.bin centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp en-ner-time.bin centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp en-pos-maxent.bin centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp en-pos-perceptron.bin centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp en-sent.bin centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp en-token.bin centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp imagenet_comp_graph_label_strings.txt centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp label.txt centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp tensorflow_inception_graph.pb centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-attributecleaner-nar-1.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-convertjsontoddl-nar-1.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-dl4j-nar-1.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-edireader-nar-0.2.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-grpc-nar-1.4.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-linkextractor-nar-1.0-SNAPSHOT.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-nlp-nar-1.6.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-tensorflow-nar-1.6.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-extracttext-nar-1.5.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-GetWebCamera-nar-1.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-langdetect-nar-1.6.0.nar  centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-imageextractor-nar-1.6.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-postimage-nar-1.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp nifi-mxnetinference-nar-1.0.nar centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp synset.txt centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp resnet50_ssd_model-symbol.json centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/
# scp resnet50_ssd_model-0000.params  centos@princeton0.field.hortonworks.com:/usr/hdf/current/nifi/lib/


# HDFS Directories

su hdfs
hdfs dfs -mkdir -p /tesseract
hdfs dfs -mkdir -p /movidiussense
hdfs dfs -mkdir -p /minifitensorflow2
hdfs dfs -mkdir -p /ethereum/price
hdfs dfs -mkdir -p /ethereum/supply
hdfs dfs -mkdir -p /yolok
hdfs dfs -mkdir -p /gluon2
hdfs dfs -mkdir -p /gluon2par
hdfs dfs -mkdir -p /etherdelta/sell
hdfs dfs -mkdir -p /etherdelta/buy
hdfs dfs -mkdir -p /etherdelta/trade
hdfs dfs -mkdir -p /etherdelta/fund
hdfs dfs -chmod -R 777 /etherdelta
hdfs dfs -mkdir -p /ethereum/tx
hdfs dfs -mkdir -p /mxnet/local
hdfs dfs -mkdir -p /ethereum/tx
hdfs dfs -mkdir -p /yolok
hdfs dfs -mkdir -p /rainbow
hdfs dfs -mkdir -p /gps
hdfs dfs -mkdir -p /roadtrip
hdfs dfs -chmod -R 777 /warehouse/tablespace/managed/hive/rainbowacid
hdfs dfs -mkdir -p /gluoncv
hdfs dfs -mkdir -p /gluon2
hdfs dfs -mkdir -p /gluon2par
hdfs dfs -mkdir -p /stocks
hdfs dfs -mkdir -p /smartplug
hdfs dfs -mkdir -p /crypto
hdfs dfs -chmod -R 777 /

# Kafka Topics

./usr/hdp/current/kafka-broker/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic gps
./usr/hdp/current/kafka-broker/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic stocks
./usr/hdp/current/kafka-broker/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic crypto
./usr/hdp/current/kafka-broker/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic smartplug
