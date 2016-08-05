To generate cookbook
$ chef generate cookbook cookbook-name 

To generate any template
$ chef generate template cookbook-name template-name 

Run a cookbook with chef-client 
$ chef-client --local-mode --runlist 'recipe[cookbook-name]'


Working with databags

Install mysql with password stored in databag in encrypted form.


As there in Vagrantfile two gems are installed for databag handling with chef-solo

$ gem install knife-solo

$ gem install knife-solo_data_bag


To verify run 

$ knife solo


Generate a secret key

$ openssl rand -base64 512 > /home/vagrant/.chef/encrypted_data_bag_secret

Create a data bag with knife 

$ knife solo data bag create mysql mysql.json --secret-file /home/vagrant/.chef/encrypted_data_bag_secret -c /vagrant/solo.rb

This should open a json file to edit

{
  "id": "mysql",
  "password": "password123"
}

View data bag

$ knife solo data bag show mysql mysql.json

Use test cookbook which is present in cookbooks and internally calls for mysql cookbook to install mysql.

$ sudo chef-solo -c solo.rb -j web.json
