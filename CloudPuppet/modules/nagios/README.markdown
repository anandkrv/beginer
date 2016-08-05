# Nagios

## Overview

This is the nagios module, it allows you to create an instance of nagios and then monitor nodes which have exported resources in your puppetdb

## Module Description

This nagios module is designed to do as little as possible in setting up a nagios node. It will set up an instance of nagios3 and then you are free to set up whatever nagios monitoring you like using the build in puppet resources for managing nagios configuration files. Specifically:

* [nagios_command](http://docs.puppetlabs.com/references/latest/type.html#nagioscommand)
* [nagios_contact](http://docs.puppetlabs.com/references/latest/type.html#nagioscontact)
* [nagios_contactgroup](http://docs.puppetlabs.com/references/latest/type.html#nagioscontactgroup)
* [nagios_host](http://docs.puppetlabs.com/references/latest/type.html#nagioshost)
* [nagios_hostdependency](http://docs.puppetlabs.com/references/latest/type.html#nagioshostdependency)
* [nagios_hostescalation](http://docs.puppetlabs.com/references/latest/type.html#nagioshostescalation)
* [nagios_hostextinfo](http://docs.puppetlabs.com/references/latest/type.html#nagioshostextinfo)
* [nagios_hostgroup](http://docs.puppetlabs.com/references/latest/type.html#nagioshostgroup)
* [nagios_service](http://docs.puppetlabs.com/references/latest/type.html#nagiosservice)
* [nagios_servicedependency](http://docs.puppetlabs.com/references/latest/type.html#nagiosservicedependency)
* [nagios_serviceescalation](http://docs.puppetlabs.com/references/latest/type.html#nagiosserviceescalation)
* [nagios_serviceextinfo](http://docs.puppetlabs.com/references/latest/type.html#nagiosserviceextinfo)
* [nagios_servicegroup](http://docs.puppetlabs.com/references/latest/type.html#nagiosservicegroup)
* [nagios_timeperiod](http://docs.puppetlabs.com/references/latest/type.html#nagiostimeperiod)

For details on how to set up nagios monitoring please view the [nagios documentation](http://nagios.sourceforge.net/docs/3_0/objectdefinitions.html).

This module is very lightweight and only has one dependency on puppetlabs/concat module

## Usage

To create a nagios monitoring node which will gather exported resources from other nodes

   include nagios::server

   nagios::user { 'nagiosadmin' :
       cryptpasswd : '$apr1$rNDzDZKH$oVGEb0BU6QZ338EuB9Hob.', # Password in htpasswd format
   }

On another node in your puppet setup

    @@nagios_host {'myhost':
       ...
    }


If you do not which to use exported resources, you can manage your entire nagios infrastructure on a single node
   
    include nagios::server

    nagios::user { 'nagiosadmin' :
       cryptpasswd : '$apr1$rNDzDZKH$oVGEb0BU6QZ338EuB9Hob.', # Password in htpasswd format
    }

    nagios_host {'myhost':
       ...
    }

To set up nrpe services on a client node declare the nagios::client class. This will install the nrpe_nagios plugins and allow access to any defined nrpe service from your nagios server
    
    class {'nagios::client' :
        nagios_server => '192.168.0.1',
    }

    nagios::nrpe { 'check_users' :
        command             => '/usr/lib/nagios/plugins/check_users -w 5 -c 10',
        notification_period => '24x7',
        service_description => 'Current Users',
        host_name           => $fqdn,
        use                 => 'generic-service',
    }

## Limitations

This module has been tested with ubuntu 12.04 lts as a server and the 
following as nrpe clients:

- Mac OS X 10.9
- Ubuntu 12.04 LTS
- Ubuntu 14.04 LTS
- CentOS 6.5



## Contributors

Christopher Johnson - cjohn@ceh.ac.uk
