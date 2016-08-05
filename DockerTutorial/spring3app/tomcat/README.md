1) docker pull tomcat:7.0

2) docker run -it --link mysqld:mysql-container -v /tmp/webapps:/usr/local/tomcat/webapps -v /tmp/tomcat-log/:/usr/local/tomcat/logs --name spring3test -d tomcat:7.0

3) cp Spring3HibernateApp.war /tmp/webapps
