mavenJob("Code Quality Test") {

  logRotator(60, 20, 1, -1)

  description('Code Quality Test for application')

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

  wrappers {
    sonarBuildWrapper {
      installationName("")
    }
  }

  goals('clean install sonar:sonar -Dsonar.host.url=$SONAR_HOST_URL')
  rootPOM('Spring3HibernateApp/pom.xml')
  mavenInstallation('maven2')
  
}
