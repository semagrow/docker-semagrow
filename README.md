# docker-semagrow

This is the docker container for the SemaGrow engine. For more info about SemaGrow check https://github.com/semagrow/semagrow

To build docker-semagrow go into the docker-semagrow directory and run

    docker build -t semagrow .

To run it 

    docker run -p <host_port>:8080 semagrow

Then you can access it from 

    http://localhost:<host_port>/SemaGrow/

SemaGrow configuration files are located at

    /etc/default/semagrow

to add external configuration files run semagrow as

    docker run -p <host_port>:8080 -v <local_dir>:/etc/default/semagrow semagrow
