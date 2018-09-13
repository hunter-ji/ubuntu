FROM ubuntu
MAINTAINER kuari


RUN apt-get update && apt-get install -y openssh-server git vim

RUN mkdir /var/run/sshd && \
    mkdir /work

RUN echo 'root:admina' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#Set history record
ENV HISTTIMEFORMAT "%F %T  "

#Fix sshd service:Read from socket failed: Connection reset by peer?
RUN ssh-keygen -A

#add .vimrc
ADD ./.vimrc /root/.vimrc

#Open 22 port
EXPOSE 22

#Auto running sshd service
CMD ["/usr/sbin/sshd","-D"]
