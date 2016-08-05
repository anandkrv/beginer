Role Name
=========

This role restores mongodb including all cases(Full, Particular, Collection) 

Role Variables
--------------

mongobackup_dir: "/opt"

mongobackup_file: "mongo-backup"

mongo_database_username: "root"

mongo_database_password: "opstree"

mongo_database_name: "opstree"

mongo_collection_name: "opstree"

password_less_login: "true"

password_login: "false"

restore_for_specific_database: "false"

restore_for_specific_collection: "false"

Here you can use these variables accordingly just by defining "true" for the case you want and "false" otherwise.


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: restore_hosts 
      roles:
         - { role: sandy724.MongoRestorer }

License
-------

BSD

Author Information
------------------
www.opstree.com

blog.opstree.com

