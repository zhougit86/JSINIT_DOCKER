# JSINIT_DOCKER


## 安装docker和docker-compose

### 安装docker

* echo " deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
* apt-get update
* apt-cache policy docker-engine
* apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
* apt-get update
* apt-get install docker-engine
* service docker start
* service docker enable
* docker ps -a
* curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
* chmod +x /usr/local/bin/docker-compose

### 文件结构

整个docker的项目主要是由以下几个文件定义的：
* docker-compose.yaml
```
version: '2'   #一般选择version2
 services:
   jsinit:     
     build:
       context: .
       dockerfile: dockers/jsinit/Dockerfile     #特定的docker生成过程，见Dockerfile的详细分析
     image: jsinit                               #生成的镜像的名字
     container_name: jsinit
     hostname: dev                               #docker的hostname
     ports:                                      #端口映射
     - "2208:22"
     - "3008:3000"
     - "4008:4000"
     - "8008:8000"
     volumes:
     - ./workspace:/workspace                   #共享的存储空间
     environment:
       NEED_INIT: T
       NEED_RUN: T
       UPSTREAM : https://github.com/zhougit86/antd-admin
```
更多配置项可以参考http://www.cnblogs.com/freefei/p/5311294.html

* dockers/jsinit/Dockerfile

分步骤实现image的生成，配置项详解：http://wiki.jikexueyuan.com/project/docker-technology-and-combat/instructions.html
在build的时候增加--force-rm 可以将中间image删除    --no-cache可以不生成缓存
在Dockerfile的最后一行  ENTRYPOINT ["/start.sh"]

由于Docker run在每一次运行后会docker会退出，所以必须手动起一些进程让他持续运行。

* start.sh

```
#!/bin/bash

cd /workspace
LOCALDIR=local-dir

if [[ ! -d "$LOCALDIR" ]];then
    git clone $UPSTREAM $LOCALDIR
else
    echo "dir already exist"
fi

if [[ "$NEED_INIT"X = "T"X ]];then
    cd $LOCALDIR&&cnpm install
fi

#tailf ~/loop
/usr/bin/supervisord -c /etc/supervisord.conf
```

