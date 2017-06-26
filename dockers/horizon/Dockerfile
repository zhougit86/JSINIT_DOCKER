FROM centos:7
MAINTAINER Joey Zhang <zhangzhuo4@lenovo.com>

USER root

# Set time zone
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN yum clean all
RUN yum install -y deltarpm
RUN yum update -y
RUN yum install -y epel-release

RUN yum update -y
RUN yum install -y openssh-server openssh-clients passwd supervisor
RUN yum groupinstall -y "Development Tools"
RUN yum install -y python-devel python-pip
RUN yum install -y vim
#RUN yum install -y ipython
RUN yum install -y npm nodejs

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

# Configure pip mirror
RUN mkdir -p /root/.pip
COPY dockers/common/pip.conf /root/.pip/pip.conf

RUN pip install --upgrade pip
RUN pip install tox

RUN mkdir -p /root/.ssh
COPY ssh/config /root/.ssh/config
COPY ssh/id_rsa /root/.ssh/id_rsa
COPY ssh/id_rsa.pub /root/.ssh/id_rsa.pub
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN chmod 400 /root/.ssh/config
RUN chmod 400 /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh

RUN git config --global user.name `cat /root/.ssh/id_rsa.pub | tr ' ' '\n' | tail -n1 | cut -d \@ -f 1`
RUN git config --global user.email `cat /root/.ssh/id_rsa.pub | tr ' ' '\n' | tail -n1`

COPY dockers/horizon/supervisord.conf /etc/supervisord.conf
COPY dockers/horizon/start.sh /start.sh
RUN chmod 755 /start.sh

COPY dockers/horizon/run_horizon.sh /usr/local/bin/run_horizon.sh
RUN chmod 755 /usr/local/bin/*.sh

RUN echo root:passw0rd | chpasswd
RUN mkdir /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

ENV REPO_HOME /opt/thinkcloud

RUN mkdir -p $REPO_HOME
RUN mkdir -p /workspace

VOLUME ["$REPO_HOME"]

EXPOSE 22 8000

ENTRYPOINT ["/start.sh"]
