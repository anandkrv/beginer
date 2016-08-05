Role Name
=========

This role installs aws cli on the host machine and configures aws with secret key and other credentials.


Role Variables
--------------

AWS_HOME: "/home/vagrant"

aws_key: "AWS_KEY"

aws_secret: "AWS_SECRET_KEY"

aws_region: "AWS_REGION"

aws_session_token: "AWS_SESSION_TOKEN"

Here aws_region and aws_session_token are optional parameters i.e.. if you want them to configure you can else they can be leave blank.
 

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts:aws_host 
      roles:
         - { role: opstree.awscli }

License
-------

BSD

Author Information
------------------
opstree.com

blog.opstree.com

