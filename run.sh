#!/bin/sh

set -e

# MongoDB interpreter
rm -f ${ZEPPELIN_HOME}/conf/zeppelin-site.xml
cp ${ZEPPELIN_HOME}/conf/zeppelin-site.xml.template ${ZEPPELIN_HOME}/conf/zeppelin-site.xml

sed -i "s@\(<value>org.apache.zeppelin.spark.SparkInterpreter.*\)\(</value.*\)@\1,org.apache.zeppelin.mongodb.MongoDbInterpreter\2@" ${ZEPPELIN_HOME}/conf/zeppelin-site.xml
sed -i "s@\(<value>spark,md.*\)\(</value.*\)@\1,mongodb\2@" ${ZEPPELIN_HOME}/conf/zeppelin-site.xml

${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh start; sleep 5; tail -F ${ZEPPELIN_HOME}/logs/zeppelin-*.log
