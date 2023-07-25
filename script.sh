yum install curl which gcc make
rpm --import https://packages.confluent.io/rpm/7.0/archive.key

yum install librdkafka-devel-1.8.2-1.cflt.el8.x86_64 librdkafka1-1.8.2-1.cflt.el8.x86_64 -y
yum install -y  openssl-devel cyrus-sasl

cd /opt/app-root/kafkacat
./bootstrap.sh
#make
#make install


