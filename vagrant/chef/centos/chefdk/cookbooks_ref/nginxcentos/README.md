nginxcentos Cookbook
====================
This cookbook simply install nginx and can setup multiple virtual host.

Requirements
------------
This cookbook has dependancy on yum-epel cookbook. This cookbok is desined for centos6.

Attributes
----------

packages = package name for nginx.
port = port to run.
webroot = address of the directory for webcontent.
servername = server name to DNS.
conffile = conf file name.
vhost = array of virtual host.


Usage
-----
#### nginxcentos::default
To install nginx use default recipe.

e.g.
Just include `nginxcentos` in your node's `run_list`:

{
  "run_list": [
    "recipe[nginxcentos]"
  ]
}

#### nginxcentos::virtualhost
To create mulltiple virtual host.
{
   "nginx": {
      "vhost": {
        "vhost1": {
          "webroot": "/usr/share/nginx/mysite",
              "servername": "blog.xebia.com",
              "conffile": "blog.xebia.com.conf"
              },
         "vhost2": {
           "webroot": "/usr/share/nginx/mysite1",
              "servername": "blog1.xebia.com",
              "conffile": "blog1.xebia.com.conf"
              }
            }
	  },
   "run_list": [
       "recipe[nginxcentos::virtualhost]"
               ]
}

License and Authors
-------------------
Authors: Sandeep Rawat
