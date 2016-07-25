FROM ubuntu
MAINTAINER suresh.bonda@gmail.com
RUN apt-get -y update
RUN apt-get -y install sudo openssh-server git vim
RUN adduser git

ADD ssh /home/git/.ssh
RUN chown -R git:git /home/git/.ssh
RUN chmod 400 /home/git/.ssh/id_rsa
RUN chmod 444 /home/git/.ssh/id_rsa.pub
RUN chmod 700 /home/git/.ssh/authorized_keys

EXPOSE 22
VOLUME ["/home/git/repositories"]
ENTRYPOINT \
        hostname gitserver && \
	echo git:P@ssw0rd | chpasswd && \
        service ssh start && \
        TERM=linux \
	/bin/bash -c "su - git"
