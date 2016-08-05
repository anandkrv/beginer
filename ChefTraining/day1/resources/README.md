# Playing with resources
''Assumption'': We would be using standalone chef for playing with resources


We will be using following resources in our system
##  Instructor
* FIle
* Package
* Service
* Directory
* Script

## Candidates
### Candidates will perform other resources and explore their attributes and actions
  * git
  * cron
  * execute
  * link
  * bash
  * group

### Candidates setup the webapp using resources
* Nginx :
  * package : epel-release, nginx
  * Configuration file : nginx.conf, ciapp.config
  * Service : Start nginx Service
* Tomcat :
  * package : tomcat
  * Deploy : deploy webapp in tomcat server
  * service : start tomcat
* MySql
  * Get rpm's : mysql-community-release-el7-5.noarch.rpm
  * Update yum package manager
  * Install mysql-server
  * Start mysql-server
  * Configure mysqldb
    *
