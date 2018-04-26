FROM python:latest

MAINTAINER Kuari "kuari@justmylife.cc"

RUN apt-get update && \
    apt-get install -y openssh-server vim && \
    mkdir /var/run/sshd && \
    echo "root:admin" | chpasswd

ADD ./.vimrc /root/.vimrc

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
