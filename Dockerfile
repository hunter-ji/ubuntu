FROM python:latest

MAINTAINER Kuari "kuari@justmylife.cc"

RUN apt-get update && \
    apt-get install -y openssh-server vim && \
    mkdir /var/run/sshd && \
    echo "root:admin" | chpasswd && \
    mkdir /work

ADD ./.vimrc /root/.vimrc

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
