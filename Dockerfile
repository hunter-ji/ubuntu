FROM python:latest

MAINTAINER Kuari "kuari@justmylife.cc"

RUN apt-get update && \
    apt-get install -y openssh-server vim emacs-nox && \
    mkdir /var/run/sshd && \
    echo "root:admin" | chpasswd && \
    mkdir /work

ADD ./.vimrc /root/.vimrc
ADD ./.emacs /root/.emacs

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
  && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && touch /root/.Xauthority \
  && true

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
