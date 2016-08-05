This module will support the mongo version starting from 3.0 series.
The existing module install the mongo server,client,tools,mongos(i.e for sharding) of latest version and there is a bug in latest 
version of mongo.
so, to install the mongo components of required version we can use the  global class of mongo module.
But the global class doesn't support the mongo 'tools' component, so we made modifications in the module to support the tools 
component of mongo.

Now how we can define class in site.pp to install all these components.
```
class {'mongodb::globals':
  manage_package_repo => true,
  server_package_name => mongodb-org-server,
  client_package_name => mongodb-org-shell,
  tools_package_name => mongodb-org-tools,
  mongos_package_name => mongodb-org-mongos,
  version => '3.0.4',
}->
class {'mongodb::server':
}->
class {'mongodb::client':
}->
class {'mongodb::tools' :}
class {'mongodb::mongos' :}
```

All above defined components can be installed by using "mongo-org".
But problem with mongo-org is it install "mongo-org" of the specified version and all below listed components of latest version.
"mongodb-org-server"
"mongodb-org-mongos"
"mongodb-org-shell"
"mongodb-org-tools"
