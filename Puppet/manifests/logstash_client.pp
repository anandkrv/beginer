#Use this command to install logstash
puppet module install elasticsearch-logstash

#run these command

echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list

#apt-key advrver keyserver.ubuntu.com --recv-keys D27D666CD88E42B4
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D27D666CD88E42B4


apt-get update

#install logstash
class { 'logstash': }
