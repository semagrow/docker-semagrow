FROM maven:3.3.3-jdk-8

MAINTAINER Yiannis Mouchakis <gmouchakis@iit.demokritos.gr>


ENV SEMAGROW_HOME /opt/semagrow

ENV PATH="$SEMAGROW_HOME/bin:$PATH"

RUN mkdir -p "$SEMAGROW_HOME"

RUN git clone https://github.com/semagrow/semagrow.git

WORKDIR semagrow

RUN git checkout fix_dependencies

RUN mvn clean package -Psemagrow-stack-webapp-distribution -DskipTests

RUN cp /semagrow/http/target/semagrow-http-1.4.1-distribution.zip $SEMAGROW_HOME

WORKDIR $SEMAGROW_HOME

RUN rm -r /semagrow

RUN unzip semagrow-http-1.4.1-distribution.zip

RUN rm semagrow-http-1.4.1-distribution.zip

COPY cp_resources /usr/local/bin/
RUN chmod +x /usr/local/bin/cp_resources

RUN mkdir -p /etc/default/semagrow

EXPOSE 8080

CMD cp_resources $SEMAGROW_HOME && catalina.sh run
