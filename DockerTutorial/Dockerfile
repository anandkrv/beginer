#Dockerfile to build MongoDB container images
# Based on Centos
############################################################

FROM centos:6.7

#Copy the repo file from current directory to container's yum.repos.d

COPY mongodb.repo /etc/yum.repos.d/mongodb.repo

# execute the commands that we specified in front of RUN

RUN yum install mongodb-org -y
RUN mkdir -p /data/db

# Expose the default port

EXPOSE 27017

# Set default container command

ENTRYPOINT ["/usr/bin/mongod"]
