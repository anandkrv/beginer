sudo chef-apply -l info -e "execute 'cp ./Spring3HibernateApp.war /var/lib/tomcat/webapps/'"
sudo chef-apply -l info -e "execute 'chmod 777  /var/lib/tomcat/webapps/Spring3HibernateApp.war'"
