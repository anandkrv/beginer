remote_file "/var/lib/tomcat/webapps/#{node['tomcat']['warfile']}.war" do
  source "#{node['tomcat']['remote_url']}"
  mode '0777'
end
