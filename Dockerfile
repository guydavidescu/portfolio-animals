FROM jenkins/jenkins:latest
USER root
RUN apt-get update && apt-get install -y docker.io
EXPOSE 8080
VOLUME /var/run/docker.sock:/var/run/docker.sock
VOLUME jenkins_home:/var/jenkins_home
