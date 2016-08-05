git config --global user.email "sandy@opstree.com"
git config --global user.name "sandy"

chef generate app chef-repo
cd chef-repo
git init
git add .
git commit -m "Initial Commit"
mkdir /home/vagrant/.chef
cp /data/opstree-validator.pem /home/vagrant/.chef
cp /data/sandy.pem /home/vagrant/.chef
cp /data/knife.rb /home/vagrant/.chef
