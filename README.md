# JSINIT_DOCKER


##安装docker和docker-compose

>安装docker
*echo " deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
*apt-get update
*apt-cache policy docker-engine
*apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
*apt-get update
*apt-get install docker-engine
*service docker start
*service docker enable
*docker ps -a
*curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
*chmod +x /usr/local/bin/docker-compose

##文件结构
整个docker的项目主要是由以下几个文件定义的：
docker-compose.yaml

>version: '2'
>services:
>  jsinit:
>    build:
>      context: .
>      dockerfile: dockers/jsinit/Dockerfile
>    image: jsinit
>    container_name: jsinit
>    hostname: dev
>    ports:
>    - "2208:22"
>    - "3008:3000"
>    - "4008:4000"
>    - "8008:8000"
>    volumes:
>    - ./workspace:/workspace
>    environment:
>      NEED_INIT: T
>      NEED_RUN: T
>      UPSTREAM : https://github.com/zhougit86/antd-admin

更多可以参考http://www.cnblogs.com/freefei/p/5311294.html
