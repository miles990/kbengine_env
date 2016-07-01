FROM centos:7

MAINTAINER AlexLee <alexlee7171@gmail.com>

RUN yum update -y
RUN yum install -y gcc gcc-c++ openssl-devel mariadb-devel git make wget unzip tmux

# Add Source Code and Demo folder(kbengine_cocos2d_js_demo)
ADD kbengine /kbengine

ADD kbengine_cocos2d_js_demo/kbengine_demos_assets /kbengine/kbengine_demos_assets

RUN chmod -R 777 /kbengine

WORKDIR /kbengine/kbe/src

RUN make

# Create user : kbe
RUN groupadd -r kbe && useradd -r -g kbe kbe

USER kbe

WORKDIR /

# RUN cd /kbengine/kbengine_demos_assets;
RUN touch start.sh && \
	echo '#!/bin/sh' >> start.sh && \
	echo 'cd /kbengine/kbengine_demos_assets' >> start.sh && \
	echo './start_server.sh &' >> start.sh && \
	chmod 777 start.sh

USER root

RUN touch start_http.sh && \
	echo '#!/bin/sh' >> start_http.sh && \	
	echo 'cd /kbengine/kbengine_cocos2d_js_demo/cocos2d-js-client' >> start_http.sh && \
	echo 'python -m SimpleHTTPServer 80' >> start_http.sh && \
	echo 'python -m http.server 80' >> start_http.sh && \
	chmod 777 start_http.sh

# docker run --rm -it miles990/kbengine_env start.sh

EXPOSE 80
