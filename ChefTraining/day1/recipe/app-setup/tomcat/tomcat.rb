package 'tomcat' do
 action :install
end

execute 'copy war file' do
  command 'cp ./Spring3HibernateApp.war /var/lib/tomcat/webapps/'
end

execute 'change permission' do
  command 'chmod 777  /var/lib/tomcat/webapps/Spring3HibernateApp.war'
end

service 'tomcat' do
 action [ :stop, :start ]
end
