FROM centos:6
MAINTAINER "Sandeep" <sandeep@opstree.com>

RUN yum -y install openssh-server openssh-clients

ADD .ssh /root/.ssh
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

ENTRYPOINT service sshd start && bash
