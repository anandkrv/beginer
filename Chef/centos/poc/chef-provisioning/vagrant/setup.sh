export CHEF_DRIVER=vagrant
export VAGRANT_DEFAULT_PROVIDER=virtualbox
chef-client -z vagrant_linux.rb machines-create.rb
