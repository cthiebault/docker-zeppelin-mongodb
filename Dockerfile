FROM openjdk:7-jdk

ENV ZEPPELIN_VERSION=0.7.0 \
    ZEPPELIN_HOME=/opt/zeppelin \
    ZEPPELIN_MONGO_VERSION=0.6.0

RUN mkdir -p ${ZEPPELIN_HOME} && \
    curl -SL http://mirror.easyname.ch/apache/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz \
      | tar xz -C ${ZEPPELIN_HOME} && \
    mv ${ZEPPELIN_HOME}/zeppelin-${ZEPPELIN_VERSION}-bin-all/* ${ZEPPELIN_HOME} && \
    rm -rf ${ZEPPELIN_HOME}/zeppelin-${ZEPPELIN_VERSION}-bin-all && \
    rm -rf *.tgz && \
    mkdir -p ${ZEPPELIN_HOME}/interpreter/mongodb && \
    curl -SL -o ${ZEPPELIN_HOME}/interpreter/mongodb/zeppelin-mongodb-${ZEPPELIN_MONGO_VERSION}.jar \
      https://github.com/bbonnin/zeppelin-mongodb-interpreter/releases/download/${ZEPPELIN_MONGO_VERSION}/zeppelin-mongodb-${ZEPPELIN_MONGO_VERSION}.zip

COPY run.sh /${ZEPPELIN_HOME}/run.sh
RUN chmod +x /${ZEPPELIN_HOME}/run.sh

EXPOSE 8080

VOLUME ${ZEPPELIN_HOME}/logs ${ZEPPELIN_HOME}/notebook

CMD ${ZEPPELIN_HOME}/run.sh