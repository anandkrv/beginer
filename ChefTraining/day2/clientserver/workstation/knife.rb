# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

#current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "workstation"
client_key               "/home/vagrant/.chef/sandy.pem"
validation_client_name   "opstree-validator"
validation_key           "/home/vagrant/.chef/opstree-validator.pem"
chef_server_url          "https://chef-server/organizations/opstree"
cookbook_path            ["/home/vagrant/chef-repo/cookbooks"]
