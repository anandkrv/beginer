Role Name
=========

This role takes mongodb backup including all cases(Full, Particular, Collection) and uploads it to S3 bucket

Role Variables
--------------
Here we can provide parameters for variable

# defaults file for opstree.mongo
backup_dir: "/opt/backup"
buket_name: "opstree"
aws_dir_name: "backupmongo"
userName: "opstree"
passWd: "opstree"
mongo_database_name: "admin"
mongo_collection_name: "people"
password_less_login: false
password_login: false
backup_for_spaecfice_database: false
backup_for_spaecfice_collection: true

Here True or False must be provided according to users requirement
For example
If database is authenticated with password use false in password_less_login and likewise 

Example Playbook
----------------
Example of how to use this role

    - hosts: mongodb_host
      roles:
         - { role: opstree.mongo }


License
-------
BSD

Author Information
------------------
Email: alok.in.ntl@gmail.com
http://blog.opstree.com

