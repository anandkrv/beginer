radamanth.mysql-ansible
=========

This Simple role install Mysql and set the defautl root passwd.

Requirements
------------

Target platform shoudl be an ubuntu with apt-get capabilities

Role Variables
--------------

mysql_root_passwd : You should override this password in vars/main.yml 

Dependencies
------------

Nonde

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: radamanth.mysql-ansible }

License
-------

GPLV2

Author Information
------------------
I've been a computer science engineer for more than 10 years now, I've discovered Ansible in 2014, and fell in love with it. I use it in my company to manage different server since then. Feel free to visit our site www.neovia.fr

I'm also one of the founder of Immozeo, where Ansible is also greatly used. ( www.immozeo.com)

