FROM centos:7

MAINTAINER AlexLee <alexlee7171@gmail.com>

RUN yum update -y
RUN yum install -y gcc gcc-c++ openssl-devel mariadb-devel git make wget unzip

ADD kbengine /kbengine

RUN chmod -R 755 /kbengine make

WORKDIR /kbengine/kbe/src

RUN make

WORKDIR /kbengine/kbengine_demos_assets

CMD ["./start_server.sh"]

