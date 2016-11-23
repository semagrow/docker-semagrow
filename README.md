# docker-semagrow

This is the docker container for the Semagrow engine. For more info about SemaGrow check https://github.com/semagrow/semagrow

To build docker-semagrow run

    docker build -t semagrow .

To run Semagrow issue 

    docker run -p <host_port>:8080 semagrow

Then you can access it from 

    http://localhost:<host_port>/SemaGrow/

To run Semagrow with you your configuration files (see https://github.com/semagrow/semagrow#configuration) issue

    docker run -p <host_port>:8080 -v </path/to/config>:/etc/default/semagrow semagrow
