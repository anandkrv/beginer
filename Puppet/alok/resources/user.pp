user { 'alok':
  ensure           => 'present',
  comment          => 'root',
  gid              => '1003',
  home             => '/alok',
  password         => '$6$B/hlJ6bc$ZtiBBwOB/zok0eNahXXeCLeLOyTpPABucWI',
  password_max_age => '99999',
  password_min_age => '0',
  shell            => '/bin/bash',
  uid              => '100000',
}

