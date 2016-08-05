mavenJob("Deployment") {

  logRotator(60, 20, 1, -1)

  description('Release for application')

	scm {
    git {
      branch('*/dev-OrclCiCdPOC')
      remote {
        name('')
        refspec('')
        url('git@github.com:OpsTree/ContinuousIntegration.git')
      }
    }     
  }

  goals('clean package')
  rootPOM('Spring3HibernateApp/pom.xml')
  mavenInstallation('maven2')
  postBuildSteps {
    shell("#!/bin/bash \n ssh -t -t tomcat@172.31.0.10 \"sudo service tomcat-oracle stop; rm -rf /srv/tomcat/oracle/webapps/*\" \n scp Spring3HibernateApp/target/Spring3HibernateApp.war tomcat@172.31.0.10:/srv/tomcat/oracle/webapps/Spring3HibernateApp.war \n ssh -t -t tomcat@172.31.0.10 \"sudo service tomcat-oracle start\"")
  }
}