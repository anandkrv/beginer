# == Class: nagios::command_sendemail
#
# This class downloads and installs the sendemail. This will enable your nagios instance
# to send email using an smtp server. 
#
# === Parameters
#
# [*smtp_server*] The smtp server to use for mailing
# [*email_address*] The email address which emails should be sent from
# [*manage_package*] If this class should install sendemail
# [*sendemail_version*] The version of send email to install
#
# === Authors
#
# Christopher Johnson - cjohn@ceh.ac.uk
#
class nagios::command_sendemail (
  $smtp_server,
  $email_address,
  $manage_package     = true,
  $sendemail_version  = installed
) {

  if $manage_package {
    package { 'sendemail' :
      ensure => $send_email_version,
    }
  }
  
  nagios_command { 'notify-host-by-sendemail':
    command_line => template('nagios/command_notifyHostBySendEmail.erb'),
  }

  nagios_command { 'notify-service-by-sendemail':
    command_line => template('nagios/command_notifyServiceBySendEmail.erb'),
  }
}