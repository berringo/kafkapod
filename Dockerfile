FROM registry.access.redhat.com/ubi8/ubi:8.0

RUN mkdir -p /opt/app-root/
WORKDIR /opt/app-root


RUN yum install -y curl which gcc make && \
    rpm --import https://packages.confluent.io/rpm/7.0/archive.key

COPY confluent.repo /etc/yum.repos.d/

RUN yum install librdkafka-devel-1.8.2-1.cflt.el8.x86_64 librdkafka1-1.8.2-1.cflt.el8.x86_64 -y && \
   mkdir -p /opt/app-root/kafkacat 
    

COPY kafkacat /opt/app-root/kafkacat
    
RUN cd /opt/app-root/kafkacat && \
    /opt/app-root/kafkacat/configure && \
    make && \
    make install

USER 1001



