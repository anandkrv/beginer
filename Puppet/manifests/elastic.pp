#Use this command install elasticsearch module
 puppet module install elasticsearch-elasticsearch
 
 #run these command
 echo 'deb http://packages.elasticsearch.org/elasticsearch/1.0/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list

 wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
 
 apt-get update 

# Install elasticsearch
  include elasticsearch 

