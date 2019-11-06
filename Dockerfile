FROM maven:3.3.3-jdk-8 as build

MAINTAINER Yiannis Mouchakis <gmouchakis@iit.demokritos.gr>

WORKDIR /

RUN git clone https://github.com/semagrow/semagrow.git && \
    cd semagrow && \
    git checkout devel-dare && \
    mvn clean package -P tomcat-bundle

FROM openjdk:8-jre-alpine

ENV SEMAGROW_HOME /opt/semagrow
ENV CATALINA_HOME $SEMAGROW_HOME
ENV PATH $CATALINA_HOME/bin:$PATH

WORKDIR /

COPY --from=build semagrow/assembly/target/semagrow-*-tomcat-bundle.tar.gz semagrow-tomcat.tar.gz

RUN    mkdir -p $SEMAGROW_HOME \
    && tar zxvf semagrow-tomcat.tar.gz -C $SEMAGROW_HOME \
    && rm semagrow-tomcat.tar.gz \
    && mkdir -p /etc/default/semagrow \
    && cp $SEMAGROW_HOME/resources/*.ttl /etc/default/semagrow

WORKDIR $SEMAGROW_HOME
 
EXPOSE 8080

CMD [ "catalina.sh", "run" ]
