FROM ubuntu:14.04
MAINTAINER Sandeep Mahto <sandeepmahto4@gmail.com>

ENV MYSQL_HOST 127.0.0.1
ENV MYSQL_USER moodle
ENV MYSQL_PASSWORD moodle
ENV MYSQL_DB moodle

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install apache2 mysql-client mysql-server php5 \
        graphviz aspell php5-pspell php5-curl php5-gd php5-intl php5-mysql php5-xmlrpc php5-ldap && \
    service apache2 restart && \
    apt-get -y install git-core wget && \
    cd /opt && \
    wget https://download.moodle.org/stable27/moodle-2.7.2.tgz && \
    tar zxvf moodle-2.7.2.tgz && \
    mv /opt/moodle/* /var/www/html/ && \
    rm /var/www/html/index.html && \
    mkdir /var/moodledata && \
    chown -R www-data /var/moodledata && \
    chmod 777 /var/moodledata && \
    chmod 777 /var/www/html/moodle && \
    chmod 777 /var/www && \
    service mysql restart 






   
