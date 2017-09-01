FROM maven:3.3.3-jdk-8

MAINTAINER Yiannis Mouchakis <gmouchakis@iit.demokritos.gr>

ENV WORKING_DIR /

ENV SEMAGROW_HOME /opt/semagrow

ENV PATH="$SEMAGROW_HOME/bin:$PATH"

RUN mkdir -p "$SEMAGROW_HOME"

RUN git clone https://github.com/semagrow/semagrow.git && \
    cd semagrow && \
    git checkout devel-bde && \
    mvn clean package -P tomcat-bundle && \
    tar xvf assembly/target/semagrow-*-tomcat-bundle.tar.gz -C $SEMAGROW_HOME && \
    cd .. && \
    rm -r semagrow

COPY cp_resources /usr/local/bin/

RUN chmod +x /usr/local/bin/cp_resources

RUN mkdir -p /etc/default/semagrow

EXPOSE 8080

CMD cp_resources $SEMAGROW_HOME && catalina.sh run
