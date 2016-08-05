class sftpjail::service{

  service { "ssh":
    ensure  => "running",
    enable  => "true",
    require => Package["openssh-server"],
  }

}
