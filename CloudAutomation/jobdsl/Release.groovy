mavenJob("Release") {

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
  
  goals('-B clean install -Dmaven.test.skip=true jgitflow:release-start')
  rootPOM('Spring3HibernateApp/pom.xml')
  mavenInstallation('maven2')
  
  postBuildSteps {
    maven {
      goals('-Dmaven.test.skip=true jgitflow:release-finish')
      rootPOM('Spring3HibernateApp/pom.xml')
      mavenInstallation('maven2')
    }
  }
}