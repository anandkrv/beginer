# Memcached

[![Puppet Forge](http://img.shields.io/puppetforge/v/jbussdieker/memcached.svg)](https://forge.puppetlabs.com/jbussdieker/memcached)
[![Build Status](https://travis-ci.org/jbussdieker/puppet-memcached.png?branch=master)](https://travis-ci.org/jbussdieker/puppet-memcached)

This module manages installing, configuring and running memcached.

# Usage

Basic Usage:

```puppet
class { 'memcached': }
```

Full options:

```puppet
class { 'memcached':
  enable_memcached => 'yes',
  log_file         => '/var/log/memcached.log',
  memory_max       => 64,
  listen_port      => 11211,
  listen_ip        => '127.0.0.1',
  memcache_user    => 'memcache',
  connection_limit => 1024
}
```
