# docker build -t spiti-jenkins .
# docker run -p 8910:8910 spiti-jenkins

FROM jenkinsci/jenkins:2.46.1

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
    && echo 'deb [arch=amd64] https://download.docker.com/linux/debian wheezy stable' > /etc/apt/sources.list.d/docker.list

RUN apt-get -y update \
    && apt-cache madison docker-ce \
    && apt-get -y install docker-ce=17.03.0~ce-0~debian-wheezy


# trust GitHub
#RUN touch ~/.ssh/known_hosts
#    && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

RUN mkdir -p /root/.ssh

RUN git config --global user.name 'jenkins' \
    && git config --global user.email 'morier.dev@outlook.com'
#RUN mkdir -p /home/jenkins/.ssh
#COPY id_rsa /home/jenkins/.ssh/id_rsa
#RUN chmod 400 /home/jenkins/.ssh/id_rsa
#RUN touch /home/jenkins/.ssh/known_hosts
#RUN echo "IdentityFile /home/jenkins/.ssh/id_rsa\nStrictHostKeyChecking no\n" > /home/jenkins/.ssh/config
#RUN chown jenkins \
#    /home/jenkins/.ssh/id_rsa \
#    /home/jenkins/.ssh/known_hosts \
#    /home/jenkins/.ssh/config