FROM maven:3.3.3-jdk-8

MAINTAINER Yiannis Mouchakis <gmouchakis@iit.demokritos.gr>


ENV SEMAGROW_HOME /opt/semagrow

ENV PATH="$SEMAGROW_HOME/bin:$PATH"

RUN mkdir -p "$SEMAGROW_HOME"

RUN git clone https://github.com/semagrow/semagrow.git && \
    cd semagrow && \
    git checkout devel-bde && \
    mvn clean package -DskipTests -Psemagrow-stack-webapp-distribution && \
    cp /semagrow/http/target/semagrow-http-*-distribution.zip $SEMAGROW_HOME && \
    cd $SEMAGROW_HOME && \
    rm -r /semagrow && \
    unzip semagrow-http-*-distribution.zip && \
    rm semagrow-http-*-distribution.zip && \
    cd /

COPY cp_resources /usr/local/bin/

RUN chmod +x /usr/local/bin/cp_resources

RUN mkdir -p /etc/default/semagrow

EXPOSE 8080

CMD cp_resources $SEMAGROW_HOME && catalina.sh run