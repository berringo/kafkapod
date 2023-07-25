FROM nginx:latest

ENV ES_ENDPOINT=https://iaf-system-es-cp4waiops.apps.infra-cert-vr2.ocp.unicreditgroup.eu
ENV ES_USERNAME=elasticsearch-admin
ENV ES_PASSWORD=Svlb1FFj8f5i84FHWd0dFw1i

#ENV BROKER=iaf-system-kafka-bootstrap-cp4waiops.apps.infra-cert-vr2.ocp.unicreditgroup.eu:443
#ENV sasl_password=j6YVky15lFUM
#COPY ./kafkacat /usr/src/kcat

#ENV BUILD_DEPS build-essential zlib1g-dev liblz4-dev libssl-dev libsasl2-dev python cmake libcurl4-openssl-dev pkg-config
#ENV RUN_DEPS libssl1.1 libsasl2-2 ca-certificates curl

#RUN apt-get update && \
#  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends $BUILD_DEPS $RUN_DEPS && \
#  echo "Building" && \
#  cd /usr/src/kcat && \
#  rm -rf tmp-bootstrap && \
#  echo "Source versions:" && \
#  grep ^github_download ./bootstrap.sh && \
#  ./bootstrap.sh --no-enable-static && \
#  mv kcat /usr/bin/ ; \
#  echo "Cleaning up" ; \
#  cd / ; \
#  rm -rf /usr/src/kcat; \
#  apt-get purge -y --auto-remove $BUILD_DEPS ; \
#  apt-get clean -y ; \
#  apt-get autoclean -y ; \
#  rm /var/log/dpkg.log /var/log/alternatives.log /var/log/apt/*.log; \
#  rm -rf /var/lib/apt/lists/*

#RUN kcat -V

COPY ./nginx.conf /etc/nginx/nginx.conf

USER root

RUN apt --allow-releaseinfo-change update && \ 
    apt -y update && \ 
    apt install -y python3 && \
    apt install -y python3-pip && \
    apt-cache policy postgis && \ 
    apt install -y postgis --no-install-recommends
  
WORKDIR /code
COPY ./resources /code/

RUN cd /code/similar-incidents-training-main/ &&  \
    pip3 install -r requirements/service.txt && \
    chgrp -R 0 /code  && \
    chmod -R g=u /code 

USER 1001 

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
