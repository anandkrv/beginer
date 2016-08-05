# PRIVATE CLASS: do not use directly
class mongodb::repo::apt inherits mongodb::repo {
  # we try to follow/reproduce the instruction
  # from http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

  include ::apt

  if($::mongodb::repo::ensure == 'present' or $::mongodb::repo::ensure == true) {
    apt::source { 'mongodb-org-3.0.list':
      location    => $::mongodb::repo::location,
      release     => "trusty/mongodb-org/3.0",
      repos       => 'multiverse',
      key         => '7F0CEB10',
      key_server  => 'hkp://keyserver.ubuntu.com:80',
      include_src => false,
    }

    Apt::Source['mongodb-org-3.0.list']->Package<|tag == 'mongodb'|>
  }
  else {
    apt::source { 'mongodb-org-3.0.list':
      ensure => absent,
    }
  }
}
