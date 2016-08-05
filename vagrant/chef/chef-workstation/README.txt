Chef Workstation  has some some dependency that are listed below which you need to have before provisioning workstation
1.) Download the chef-validator.pem from chef server 
2.) Download the admin.pem from chef server
3.) Once you boot up your Vagrant VM for chef workstation, you need to configure knife "knife configure --initial"
4.) Now to bootstrap, we can use knife bootstrat. As we are doing provisioning using vagrant only so we can use the vagrant user name & password ideally the workstation should have password less login to host machine
knife bootstrap <vagrant machine ip> -x vagrant -P vagrant -N <name_for_node> --sudo  
