# == Class: redis
#
# This class installs and redis on RHEL based machines
#
#
# === Examples
#
# * Installation:
#     class { 'redis': }
#
#
# === Parameters
#
# [*version*]
#   Version of Redis to install.
#   latest, installed, absent, or specific version number are valid
#   Default: latest
#
# [*port*]
#   What port should Redis listen on.
#   Default: 6379
#
# [*listen*]
#   Address for Redis to listen on
#   Default: 127.0.0.1
#
# [*unixsocket*]
#   Name of unix socket for Redis to create to listen on
#   Defult: none
#
# [*Redis_loglevel*]
#   The Redis loglevel
#   debug, verbose, notice, warning are valid options
#   Default: notice
#
# [*databases*]
#   Number of databases to create
#   Default: 16
#
# [*save*]
#   Array database save intervals in the format '<seconds> <changed_keys>'
#   Default ['900 1', '300 10', '60 10000']
#
# [*masterip*]
#   The IP of the master Redis server this server should be a slave of.
#   Default: blank (not a slave)
#
# [*masterport*]
#   The port of the master Redis server this server is a slave of
#   Default: '6379'
#
# [*masterauth*]
#   Password for replication authentication
#   Default: blank
#
# [*requirepass*]
#   Password connectivity
#   Default: blank
#
# [*maxclients*]
#   Maximum number of client connections
#   Default: 128
#
# [*maxmemory*]
#   Maximum amount of memory Redis will use
#   Default: empty
#
# [*maxmemory_policy*]
#   How Redis decides what is removed from memory when maxmemory is reached
#   volatile-lru, allkeys-lru, volatile-random, allkeys-random, voltaile-ttl, noevection are valid
#   Default: volatile-lru
#
# [*appendonly*]
#   Enable Redis's fully-durable append file
#   Default: no
#
# [*appendfsync*]
#   Method of fsyncing the append file
#   no, always, everysec are valid options
#   Default: everysec
#
# [*auto_aof_rewrite_percentage*]
#   Percentage of append file to force a rewrite
#   Default: 100
#
# [*auto_aof_rewrite_min_size*]
#   Ignore append files less than this size
#   Default: 64mb
#
# [*slowlog_log_slower_than*]
#   Log queries slower than this (ms)
#   Default: 10000
#
# [*slowlog_max_len*]
#   Maximum log size for the slowlog
#   Default: 1024
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# TODO - backups
class redis (
  $version                      = 'latest',
  $port                         = '6379',
  $listen                       = '127.0.0.1',
  $unixsocket                   = '',
  $redis_loglevel               = 'notice',
  $databases                    = 16,
  $save                         = [ '900 1', '300 10', '60 10000'],
  $masterip                     = '',
  $masterport                   = '6379',
  $masterauth                   = '',
  $requirepass                  = '',
  $maxclients                   = 128,
  $maxmemory                    = '',
  $maxmemory_policy             = 'volatile-lru',
  $appendonly                   = 'no',
  $appendfsync                  = 'everysec',
  $auto_aof_rewrite_percentage  = '100',
  $auto_aof_rewrite_min_size    = '64mb',
  $slowlog_log_slower_than      = 10000,
  $slowlog_max_len              = 1024,
) {

  class { 'redis::install': version => $version } ->
  class { 'redis::config':
    port                        => $port,
    listen                      => $listen,
    unixsocket                  => $unixsocket,
    redis_loglevel              => $redis_loglevel,
    databases                   => $databases,
    save                        => $save,
    masterip                    => $masterip,
    masterport                  => $masterport,
    masterauth                  => $masterauth,
    requirepass                 => $requirepass,
    maxclients                  => $maxclients,
    maxmemory                   => $maxmemory,
    maxmemory_policy            => $maxmemory_policy,
    appendonly                  => $appendonly,
    appendfsync                 => $appendfsync,
    auto_aof_rewrite_percentage => $auto_aof_rewrite_percentage,
    auto_aof_rewrite_min_size   => $auto_aof_rewrite_min_size,
    slowlog_log_slower_than     => $slowlog_log_slower_than,
    slowlog_max_len             => $slowlog_max_len,
  } ~>
  class { 'redis::service': } ->

  Class['redis']

}
