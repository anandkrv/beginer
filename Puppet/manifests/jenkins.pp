
#Use this command to install jenkins  puppet module
puppet module install rtyler-jenkins

#Manifest file

Exec {
     path => [
             '/usr/local/bin',
             '/opt/local/bin',
             '/usr/bin',
             '/usr/sbin',
             '/bin',
             '/sbin'],
             logoutput => true,
}

include jenkins

jenkins::plugin {
  "git" : ;
  "parameterized-trigger" : ;
  "token-macro" : ;
  "mailer" : ;
  "scm-api" : ;
  "promoted-builds" : ;
  "matrix-project" : ;
  "git-client" : ;
  "ssh-credentials" : ;
  "credentials" : ;
}

jenkins::user {'opstree':
  full_name => 'opstree',
  email    => 'opstree@gmail.com',
  password => 'password',
  before => Class['jenkins::security'],
}

class{'jenkins::security':
   security_model => 'full_control',
}



