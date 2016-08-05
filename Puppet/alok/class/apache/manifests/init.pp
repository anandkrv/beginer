class apache {
  package { 'apache2':
      ensure=>'installed'
  }

  notify { 'Apache is installed.':
  }

  service { 'apache2':
      ensure=>'running'
  }

  notify { 'apache is running.':
  }
}
