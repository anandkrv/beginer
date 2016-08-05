Role Name
=========

By this role we can 
* change hostname
* Install Puppet agent
* Make config file for puppet agent
* Sync with puppet master

Role Variables
--------------
hostname: "hostname to be set"
server: "Puppet master server ip/domain name"
certname: ""


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: Puppet-node-name
      roles:
         - { role: "opstree.puppetsync" }

License
-------

BSD

Author Information
------------------
www.opstree.com
blog.opstree.com
