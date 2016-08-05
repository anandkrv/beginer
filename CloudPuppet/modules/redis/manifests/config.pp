# == Class: redis::config
#
# This class writes out the redis config file
#
#
# === Parameters
#
# See the init.pp for parameter information.  This class should not be direclty called.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class redis::config (
  $port,
  $listen,
  $unixsocket,
  $redis_loglevel,
  $databases,
  $save,
  $masterip,
  $masterport,
  $masterauth,
  $requirepass,
  $maxclients,
  $maxmemory,
  $maxmemory_policy,
  $appendonly,
  $appendfsync,
  $auto_aof_rewrite_percentage,
  $auto_aof_rewrite_min_size,
  $slowlog_log_slower_than,
  $slowlog_max_len
) {

  file { '/etc/redis.conf':
    ensure  => file,
    owner   => 'redis',
    group   => 'redis',
    mode    => '0444',
    content => template('redis/redis.conf.erb'),
  }

}