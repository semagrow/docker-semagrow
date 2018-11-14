# docker-semagrow

This is the docker container for the Semagrow engine. For more info about Semagrow check https://github.com/semagrow/semagrow

To build docker-semagrow run

    docker build -t semagrow .

To run Semagrow issue 

    docker run -p <host_port>:8080 semagrow

Then you can access it from 

    http://localhost:<host_port>/SemaGrow/

To run Semagrow with your configuration file (see https://github.com/semagrow/semagrow#configuration) issue

    docker run -p <host_port>:8080 -v </path/to/metadata.ttl>:/etc/default/semagrow/metadata.ttl semagrow

Semagrow can also be deployed using docker compose. First edit the docker-compose.yml file and replace `/path/to/metadata.ttl` with the path to your configuration file. Then issue

    docker-compose up -d
