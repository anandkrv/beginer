### Description to configure the tomcat through the Puppet module (camptocamp)
## Dependency 
* Java should be installed.

## Installing tomcat 
```
class { 'tomcat':
  version     =>  '8',
  sources     =>  true,
  sources_src =>  'http://archive.apache.org/dist/tomcat/'
}
```
This will put the catalina home into the /opt directory 
