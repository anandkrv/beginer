1) mkdir -p /tmp/mysql/ /tmp/logs/ && touch /tmp/logs/mysqld.log && chmod 777  /tmp/logs/mysqld.log

2) docker build -t mysql .

3) docker run -it --name mysqldb -v /tmp/mysql:/var/lib/mysql -v /tmp/logs/mysqld.log:/var/log/mysqld.log -d mysql
