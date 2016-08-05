The purpose of this vagrant setup is to use aws for any chef related activity

* Region : Singapore
* Community AMI : ami-50025a02
* Chefdk Donwload url :  https://packages.chef.io/stable/el/6/chefdk-0.16.28-1.el6.x86_64.rpm
  * wget --no-check-certificate  https://packages.chef.io/stable/el/6/chefdk-0.16.28-1.el6.x86_64.rpm
* Chef Server Download url : https://packages.chef.io/stable/el/6/chef-server-core-12.8.0-1.el6.x86_64.rpm
  * wget --no-check-certificate https://packages.chef.io/stable/el/6/chef-server-core-12.8.0-1.el6.x86_64.rpm
* As an alternate you can copy scripts directly to target AWS server and can setup either server or chefdk
  * scp /data/*.sh root@<tgt m/c ip>: 
* Update id_rsa
* curl https://raw.githubusercontent.com/OpsTree/ChefTraining/master/aws/awskey.pem > ~/.ssh/id_rsa
* chmod 400 ~/.ssh/id_rsa
