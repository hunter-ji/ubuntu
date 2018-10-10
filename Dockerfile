FROM mysql

RUN apt-get update && apt-get install -y openssh-server

RUN echo 'root:admina' | chpasswd

RUN mkdir /var/run/sshd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#Set history record
ENV HISTTIMEFORMAT "%F %T  "

#Fix sshd service:Read from socket failed: Connection reset by peer?
RUN ssh-keygen -A

#Open 22 port
EXPOSE 22

# Add run.sh
COPY run.sh /

#Auto running sshd service
CMD ["bash /run.sh"]
