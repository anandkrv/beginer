#Setup will be done on Ubuntu
* Region : ami-21d30f42
* AMI : ami-21d30f42
* Chefdk setup : chefClientSetupUbuntu.sh

# Knife setup
* Run knife configure
* Provide a path to a chef repository, leave rest of entries as is
* Create a local git repository for cookbooks folder
  * cd /root/opstree/cookbooks
  * git init
  * echo "Readme" > Readme.md
  * git add Readme.md
  * git config --global user.name "Sandy"
  * git config --global user.email sandy@opstree.com
  * git  commit -m "Created readme"


# Downdloading cookbooks from chef Community
* Install MySql Community cookbook
  * knife cookbook site install mysql 6.0.2
* Create a wrapper cookbook to perform required operation
  * knife cookbook create ciwrapper
  * chef generate cookbook ciwrapper
  * Add a recipe for MySql
    * chef generate recipe ciwrapper database
    * Update database recipe of ciwrapper
      * Create a mysql service using service resource of mysql
      * Create employeedb database using bash resource
      * Refer cookbooks/ciwrapper/recipes/database.rb
    * Add depends statement in metadata.rb for mysql
    * Validate
      * chef-client -z -o ciwrapper::database
  * Add a recipe for tomcat
    * chef generate recipe ciwrapper tomcat
    * Update tomcat recipe of ciwrapper
      * Install tomcat
      * Start tomcat service
      * Upload Spring3HibernateApp
      * Refer cookbooks/ciwrapper/recipes/tomcat.rb
    * Add depends statement in metadata.rb for tomcat
    * Validate
      * chef-client -z -o ciwrapper::tomcat
* Install Java community cookbook
  * knife cookbook site install java 1.41.0
* Install tomcat community cookbook
  * knife cookbook site install tomcat 2.3.1
* Install nginx community cookbook
  * knife cookbook site install nginx 2.7.6
    * Update Dependencies in metadata.rb to >=0.0
      * apt
      * build-essentials
    * Update ohai installation
      * Remove existing ohai cookbook
      * Install 2.1.0 version of ohai cookbook
        * knife cookbook site install ohai 2.1.0
  * Update nginx template socketproxy.conf.erb
    * Refer nginx/templaes/default/modules/scoketproxy.conf.erb
* Create runlist
  * Define attributes required by various cookbooks
    * java
    * nginx
  * Execute the runlist
    * chef-client -z -j cisetup.json
