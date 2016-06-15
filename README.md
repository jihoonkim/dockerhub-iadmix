# dockerhub-iadmix
Docker container for iadmix 

### build a docker container from the latest Dockerfile in Git Hub
docker build -t j5kim/iadmix:latest github.com/jihoonkim/dockerhub-iadmix

### push the built Docker image to Docker Hub
docker login
docker push  j5kim/iadmix:latest 

### test run docker with an example input
docker run -t -i -m 4g -v /Users/JohnDoe:/mydata j5kim/iadmix:latest /bin/bash /opt/runexample.sh

### run with a user's own input data
docker run -t -i -m 4g -v /Users/JohnDoe:/mydata j5kim/iadmix:latest /bin/bash /opt/workflow.sh /mydata/runinput/run.cfg
