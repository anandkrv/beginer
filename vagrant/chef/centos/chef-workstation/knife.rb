# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

#current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "sandeep"
client_key               "/home/vagrant/.chef/sandeep.pem"
validation_client_name   "xebia-validator"
validation_key           "/home/vagrant/.chef/xebia-validator.pem"
chef_server_url          "https://chef-server/organizations/xebia"
cookbook_path            ["/vagrant/chef-repo/cookbooks"]

