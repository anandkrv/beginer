# Moving ahead from individual recipes to a packaged setup
''Assumption'': We already have individual resources & grouped recipes in place now we will create use cookbook to do our standard setup

## Custom cookbooks
### Nginx cookbook
* Create a cookbooks directory
  * mkdir cookbooks
  * cd cookbooks
* Create cookbook structure for nginx
  * chef generate cookbook nginx
* Create install recipe for Nginx
  * chef generate recipe nginx install
  * Things to be done
    * Install epel-release & nginx package
    * Refer nginx/recipes/install.rb
  * Validate
    * chef-client -z -o nginx::install
* Create service recipe for nginx
  * chef generate recipe nginx service
  * Things to be done
    * Start nginx service
    * Refer nginx/recipes/service.rb
  * Validate
    * chef-client -z -o nginx::service
* Create config recipe for nginx
  * chef generate recipe nginx config
  * Things to be done
    * Delete below files
      * /etc/nginx/conf.d/default.conf
      * /etc/nginx/conf.d/ssl.conf
      * /etc/nginx/conf.d/virtual.conf
    * Create a new nginx server configuration file
      * /etc/nginx/conf.d/server.conf
      * Refer nginx/files/default/server.conf
    * Create an index.html for our default server
      * Refer nginx/files/default/index.html
    * Refer nginx/recipes/config.rb
* Club all the recipes into default recipe
  * Things to be done
    * include install, service & config recipe in default recipe
    * Refer default.rb
* Add a capability to create dynamic host using an attribute
  * Generate default attribute
    * chef generate attribute nginx default
    * Things to be done
      * Add an attribute entry ['nginx']['server']='sandeep'
      * Refer file nginx/attributes/default.rb
  * Generate a template for vhost
    * chef generate template nginx vhost
    * Things to be done
      * Generate a template file using the attribute ['nginx']['server']
      * Refer nginx/template/vhost.rb
  * Generate a template for vhost index file
    * chef generate template nginx vhostindex
    * Things to be done
      * Generate a template file using the attribute ['nginx']['server']
      * Refer nginx/template/vhostindex.rb
  * Generate recipe file for our dynamic vhost
    * chef generate recipe nginx vhost
    * Things to be done
      * Create a directory for new vhost
      * Create a vhost configuration file
      * Create an index file for your vhost

### Tomcat cookbook
* Create cookbook structure for tomcat
  * chef generate cookbook tomcat
* Create install recipe for tomcat
  * chef generate recipe tomcat install
  * Things to be done
    * Install tomcat 
    * Refer tomcat/recipes/install.rb
  * Validate
    * chef-client -z -o tomcat::install
* Create service recipe for tomcat
  * chef generate recipe tomcat service
  * Things to be done
    * Start tomcat service
    * Refer tomcat/recipes/service.rb
  * Validate
    * chef-client -z -o tomcat::service
* Create deploy recipe for tomcat
  * chef generate recipe tomcat deploy
  * Refer nginx/recipes/deploy.rb
  * Validate
    * chef-client -z -o tomcat::deploy
* Club all the recipes into default recipe
  * Things to be done
    * include install, service & config recipe in default recipe
    * Refer default.rb
* Add a capability to download warfile from dynamic remote URL using an attribute
  * Generate default attribute
    * chef generate attribute tomcat default
    * Things to be done
      * Add an attribute entry ['tomcat']['remote_url']='URL'
      * Refer file tomcat/attributes/default.rb

### MySql cookbook
* Create cookbook structure for mysql
  * chef generate cookbook mysql
* Create install recipe for mysql
  * chef generate recipe mysql install
  * Things to be done
    * Install mysql-server package
    * Set root password
    * Create a setrootpassword.sql file with following content in /tmp diretory
	SET PASSWORD FOR 'root'@'localhost' = PASSWORD('password');
	FLUSH PRIVILEGES;
    * Refer mysql/recipes/install.rb
  * Validate
    * chef-client -z -o mysql::install
* Create service recipe for mysql
  * chef generate recipe mysql service
  * Things to be done
    * Stop and Start mysql service
    * Refer mysql/recipes/service.rb
  * Validate
    * chef-client -z -o mysql::service
* Create config recipe for mysql
  * chef generate recipe mysql config
  * Things to be done
    * Refer nginx/recipes/config.rb
  * Validate
    * chef-client -z -o mysql::config
* Club all the recipes into default recipe
  * Things to be done
    * include install, service & config recipe in default recipe
    * Refer default.rb
* Add a capability to create dynamic host using an attribute
  * Generate default attribute
    * chef generate attribute mysql default
    * Things to be done
      * Add an attribute entry default['mysql']['root_password']='password'
      * Refer file mysql/attributes/default.rb
  * Generate a template for setrootpassword.sql
    * chef generate template mysql setrootpassword.sql
    * Things to be done
      * Generate a template file using the attribute default['mysql']['root_password']
      * Refer nginx/template/setrootpassword.sql.erb     

## Marketplace cookbook
