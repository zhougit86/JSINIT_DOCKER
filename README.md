# JSINIT_DOCKER


##安装docker和docker-compose

>安装docker
>*echo " deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
>*apt-get update
>*apt-cache policy docker-engine
>*apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
>*apt-get update
>*apt-get install docker-engine
>*service docker start
>*service docker enable
>*docker ps -a
>*curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
>*chmod +x /usr/local/bin/docker-compose
