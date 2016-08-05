tomcat_install 'default' do
  version '8.0.36'
end

tomcat_service 'default' do
  action :start
end

remote_file "/opt/tomcat_default/webapps/Spring3HibernateApp.war" do
  source "https://s3-ap-southeast-1.amazonaws.com/xdevopstraining/Spring3HibernateApp.war"
  mode '0777'
end
