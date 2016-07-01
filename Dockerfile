FROM centos:7

MAINTAINER AlexLee <alexlee7171@gmail.com>

RUN yum update -y
RUN yum install -y gcc gcc-c++ openssl-devel mariadb-devel git make wget unzip

ADD kbengine /kbengine

RUN chmod -R 755 /kbengine

WORKDIR /kbengine/kbe/src

RUN make

WORKDIR /kbengine

RUN git clone https://github.com/kbengine/kbengine_demos_assets.git

RUN chmod -R 755 /kbengine/kbengine_demos_assets

WORKDIR /kbengine/kbengine_demos_assets

RUN groupadd -r kbe && useradd -r -g kbe kbe

# CMD ["./start_server.sh"]

