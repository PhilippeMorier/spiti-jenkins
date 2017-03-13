# docker build -t spiti-jenkins .
# docker run -p 8910:8910 spiti-jenkins

FROM jenkinsci/jenkins:2.32.3

MAINTAINER Philippe Morier <morier.dev@outlook.com>

USER jenkins

COPY plugins.txt /plugins.txt
RUN /usr/local/bin/install-plugins.sh $(cat /plugins.txt | tr '\n' ' ')

# COPY https.pem /var/lib/jenkins/cert
# COPY https.key /var/lib/jenkins/pk
# ENV JENKINS_OPTS --httpPort=-1 --httpsPort=8083 --httpsCertificate=/var/lib/jenkins/cert --httpsPrivateKey=/var/lib/jenkins/pk
ENV JENKINS_OPTS --httpPort=8910
EXPOSE 8910
