class sftpjail::client(
$group_name = '',
$user_pass = [],
$user_groups = [],
$homedir = ''
){
  include stdlib
  include sftpjail::service
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

  package{"openssh-server":
    ensure => present
  }

  file_line {"internal_sftp":
    path => "/etc/ssh/sshd_config",
    ensure => present,
    line => "Subsystem sftp internal-sftp",
    match => "Subsystem sftp /usr/lib/openssh/sftp-server",
    require => Package['openssh-server']
  }

  exec{"groupname":
                       command => "echo 'Match Group $group_name
        ChrootDirectory /sftp/%u
        ForceCommand internal-sftp' >> /etc/ssh/sshd_config",
                       unless => "grep $group_name /etc/ssh/sshd_config",
                       require => File_line['internal_sftp'],
                       notify  => Class['sftpjail::service']
  }

  class{"sftpjail::user":
    homedir => "$homedir",
    group_name => "$group_name",
    user_pass => $user_pass
  }

}

