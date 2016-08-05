action :configure do

[:webroot, :conffile, :servername, :port].each do |attr|
       unless new_resource.instance_variable_get("@#{attr}")
         new_resource.instance_variable_set("@#{attr}", node['nginx'][attr])
       end
     end


 [:webroot].each do |attr|
       directory new_resource.instance_variable_get("@#{attr}") do
         mode '0755'
         recursive true
       end
       template "#{new_resource.webroot}/index.html" do
         source 'index.html.erb'
         variables(
          servername: new_resource.servername
        )
       end
     end

 template "/etc/nginx/conf.d/#{new_resource.conffile}" do
   source 'chefmanagedconf.conf.erb'
   variables(
          port: new_resource.port,
          servername: new_resource.servername,
          webroot: new_resource.webroot
        )
 end

 line = "127.0.0.1 #{new_resource.servername}"
 file = Chef::Util::FileEdit.new('/etc/hosts')
 file.insert_line_if_no_match(/#{line}/, line)
 file.write_file

end
