mavenJob("Selenimun Test") {

  logRotator(60, 20, 1, -1)

  description('Selenium Test for application')

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
    xvfb('Default') {
    }
  }

  goals('clean install sonar:sonar -Dsonar.host.url=$SONAR_HOST_URL')
  rootPOM('EmployeeAutomation/pom.xml')
  mavenInstallation('maven2')

  publishers {
    htmlPublisher {
      reportTargets {
        htmlPublisherTarget {
          reportName('HTML Report')
          reportFiles('index.html')
          reportDir('EmployeeAutomation/target/surefire-reports')  
          keepAll(false)
          alwaysLinkToLastBuild(false)
          allowMissing(false)        
        }
      }
    } 
  }
  
}