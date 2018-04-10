FROM ubuntu
RUN rm /etc/apt/sources.list 
ADD ./sources.list /etc/apt/
RUN apt-get clean && apt-get update
