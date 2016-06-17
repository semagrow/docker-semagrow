FROM maven:3.3.3-jdk-8

MAINTAINER Yiannis Mouchakis <gmouchakis@iit.demokritos.gr>

ENV WORKING_DIR /

ENV SEMAGROW_HOME /opt/semagrow

ENV PATH="$SEMAGROW_HOME/bin:$PATH"

RUN mkdir -p "$SEMAGROW_HOME"

RUN git clone https://github.com/semagrow/semagrow.git && \
    cd semagrow && \
    mvn clean install -DskipTests -Psemagrow-stack-webapp-distribution && \
    cp /semagrow/http/target/semagrow-http-*-distribution.zip $SEMAGROW_HOME && \
    cd $SEMAGROW_HOME && \
    unzip semagrow-http-*-distribution.zip && \
    unzip domains/localhost/webapps/SemaGrow.war -d domains/localhost/webapps/SemaGrow/ && \
    cd / && \
    git clone https://github.com/semagrow/semagrow-quetsal.git && \
    cd semagrow-quetsal && \
    mvn clean package && \
    cp target/semagrow-quetsal-*.jar $SEMAGROW_HOME/domains/localhost/webapps/SemaGrow/WEB-INF/lib/ && \
    mvn dependency:copy-dependencies && \
    cp target/dependency/*.jar $SEMAGROW_HOME/domains/localhost/webapps/SemaGrow/WEB-INF/lib/ && \
    cd / && \
    rm -r semagrow && \
    rm -r semagrow-quetsal && \
    rm $SEMAGROW_HOME/semagrow-http-*-distribution.zip && \
    rm $SEMAGROW_HOME/domains/localhost/webapps/SemaGrow.war
    

COPY cp_resources /usr/local/bin/

RUN chmod +x /usr/local/bin/cp_resources

RUN mkdir -p /etc/default/semagrow

EXPOSE 8080

CMD cp_resources $SEMAGROW_HOME && catalina.sh run
