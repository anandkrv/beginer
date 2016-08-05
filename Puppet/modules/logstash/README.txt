---- MODULE DESCRIPTION ----

This module installs and manages logstash software and configuration.
Through declaration, you can configure directors and configuration files.
It's usable on Debian 5/6 & Redhat 4/5/6 systems.


---- PRE-REQUISITES ----

1° Java must be installed on your system
2° Ensure command "which java" return the good java luncher path



---- CONFIGURATION ----

1° Download latest logstash version and configure install.pp 
ex : logstash-1.1.1-monolithic.jar
     open /logstash/manifest/install.pp
     Modify $logstash_binary value by name of your logstash binary name : 
     --> $logstash_binary = 'logstash-1.1.1-monolithic.jar'

2° Push binary in file directory
ex : mv logstash-1.1.1-monolithic.jar/logstash/files/



---- EXEMPLE : USAGE OF CONFIGURATION FILES ----

This puppet module provides management of configuration files :
- basic configuration files for all nodes
- configuration files specific by host

host : "foobar"
Monitored software : "postgres"

If you have a host with specific software (postgres), you can add a
configuration file named "logstash_postgres.foobar" in the
logstash/files/conf.d/ directory of the puppetmaster.
You can imagine that logstash_postgres.conf manages a lot of postgres
instances log files.
After a puppet run, host named 'foobar' has in /etc/logstash/conf.d/
files logstash_base.conf and logstash_postgres.conf

