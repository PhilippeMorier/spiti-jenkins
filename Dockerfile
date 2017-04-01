# docker build -t spiti-jenkins .
# docker run -p 8910:8910 spiti-jenkins

FROM jenkins:2.32.3

MAINTAINER Philippe Morier <morier.dev@outlook.com>

USER jenkins

COPY plugins.txt /plugins.txt
RUN /usr/local/bin/install-plugins.sh $(cat /plugins.txt | tr '\n' ' ')

ENV JENKINS_OPTS --httpPort=8910
EXPOSE 8910

# Install docker the official way by adding the repo but specific for wheezy
# https://github.com/docker/docker/issues/31495#issuecomment-284139690
USER root

RUN apt-get -y update \
    && apt-get -y install apt-transport-https curl \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && echo "deb [arch=amd64] https://download.docker.com/linux/debian wheezy stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get -y update \
    && apt-cache madison docker-ce \
    && apt-get -y install docker-ce=17.03.0~ce-0~debian-wheezy

#RUN usermod -aG docker jenkins
#RUN chmod +x /usr/bin/docker
#USER jenkins
#RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Inofficial way to install docker
#https://github.com/marcelbirkner/docker-ci-tool-stack/blob/master/jenkins/Dockerfile
#RUN curl -sSL -O https://get.docker.com/builds/Linux/x86_64/docker-17.03.0-ce.tgz \
#    && tar -xvzf docker-17.03.0-ce.tgz -C /usr/bin/
#RUN mv docker/* /usr/bin/

# http://container-solutions.com/running-docker-in-jenkins-in-docker/
# https://medium.com/@mccode/understanding-how-uid-and-gid-work-in-docker-containers-c37a01d01cf#.9bdg04697
# https://damnhandy.com/2016/03/06/creating-containerized-build-environments-with-the-jenkins-pipeline-plugin-and-docker-well-almost/
# https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/

# https://hub.docker.com/r/atlassianlabs/docker-node-jdk-chrome-firefox/~/dockerfile/
# https://github.com/jenkinsci/pipeline-model-definition-plugin/wiki/Syntax-Reference