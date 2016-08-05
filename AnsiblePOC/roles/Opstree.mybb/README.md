Role Name
=========

This role installs mybb forum .


Dependencies
------------
No Dependencies

------------
Role Variables
--------------
Here we can provide parameters for variables
- default/main.yml


***********parameters************
mybb_version: "1806"
nginx_root_path: "/var/www/html"
server_name: "mybb.com"
epel_repo_url: "https://dl.fedoraproject.org/pub/epel/epel-release-latest-{{ ansible_distribution_major_version }}.noarch.rpm"
epel_repo_gpg_key_url: "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-{{ ansible_distribution_major_version }}"


Example of how to use this role

    - hosts: mybb_hosts
      roles:
         - { role: Opstree.mybb }

License
-------

Author Information
------------------
Email: alok.in.ntl@gmail.com
http://blog.opstree.com
http://opstree.com
