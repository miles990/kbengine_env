FROM centos:7

MAINTAINER AlexLee <alexlee7171@gmail.com>

RUN yum update -y
RUN yum install -y gcc gcc-c++ openssl-devel mariadb-devel git make wget unzip

# Add Source Code
ADD kbengine /kbengine

RUN chmod -R 777 /kbengine

WORKDIR /kbengine/kbe/src

RUN make

# Get Demo assets
WORKDIR /kbengine

RUN git clone https://github.com/kbengine/kbengine_cocos2d_js_demo.git

WORKDIR /kbengine/kbengine_cocos2d_js_demo
RUN git submodule update --init --remote

RUN chmod -R 777 /kbengine/kbengine_cocos2d_js_demo && \
	cp -a /kbengine/kbengine_cocos2d_js_demo/kbengine_demos_assets /kbengine

RUN cd /kbengine/kbengine_cocos2d_js_demo/cocos2d-js-client/; python -m SimpleHTTPServer 80; python -m http.server 80

WORKDIR /kbengine/kbengine_demos_assets

# Create user : kbe
RUN groupadd -r kbe && useradd -r -g kbe kbe

USER kbe

# CMD ["./start_server.sh"]

