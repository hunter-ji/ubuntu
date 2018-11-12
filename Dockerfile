FROM ubuntu:latest

MAINTAINER Kuari "kuari@justmylife.cc"

RUN apt-get update && \
    apt-get install -y openssh-server vim emacs-nox && \
    mkdir /var/run/sshd && \
    echo "root:admin" | chpasswd && \
    mkdir /work

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

ADD ./.vimrc /root/.vimrc
ADD ./.emacs /root/.emacs

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
