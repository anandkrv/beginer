require 'spec_helper'

describe 'redis::config' do

  context 'default' do

    let(:params) { {
      :port => '6379',
      :listen => '127.0.0.1',
      :unixsocket => '',
      :redis_loglevel => 'notice',
      :databases => 16,
      :save => [ '900 1', '300 10', '60 10000'],
      :masterip => '',
      :masterport => '6379',
      :masterauth => '',
      :requirepass => '',
      :maxclients => 128,
      :maxmemory => '',
      :maxmemory_policy => 'volatile-lru',
      :appendonly => 'no',
      :appendfsync => 'everysec',
      :auto_aof_rewrite_percentage => '100',
      :auto_aof_rewrite_min_size => '64mb',
      :slowlog_log_slower_than => 10000,
      :slowlog_max_len => 1024
    } }

    it { should contain_file('/etc/redis.conf') }
    it { should contain_file('/etc/redis.conf').with(:content => /^port\s6379$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^bind\s127\.0\.0\.1$/) }
    it { should_not contain_file('/etc/redis.conf').with(:content => /^unixsocket.*$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^loglevel\snotice$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^databases\s16$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^save\s900\s1$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^save\s300\s10$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^save\s60\s10000$/) }
    it { should_not contain_file('/etc/redis.conf').with(:content => /^slaveof.*$/) }
    it { should_not contain_file('/etc/redis.conf').with(:content => /^masterauth.*$/) }
    it { should_not contain_file('/etc/redis.conf').with(:content => /^requirepass.*$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^maxclients\s128$/) }
    it { should_not contain_file('/etc/redis.conf').with(:content => /^maxmemory\s.*$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^maxmemory\-policy\svolatile\-lru$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^appendonly\sno$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^appendfsync\severysec$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^auto\-aof\-rewrite\-percentage\s100$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^auto\-aof\-rewrite\-min\-size\s64mb$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^slowlog\-log\-slower\-than\s10000$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^slowlog\-max\-len\s1024$/) }
  end

  context 'setting params' do
    let(:params) { {
      :port => '1234',
      :listen => '1.2.3.4',
      :unixsocket => '/tmp/redis.sock',
      :redis_loglevel => 'verbose',
      :databases => 1,
      :save => [ '300 1'],
      :masterip => '1.2.3.5',
      :masterport => '2345',
      :masterauth => 'secretpass',
      :requirepass => 'mypass',
      :maxclients => 256,
      :maxmemory => '100mb',
      :maxmemory_policy => 'volatile-random',
      :appendonly => 'yes',
      :appendfsync => 'always',
      :auto_aof_rewrite_percentage => '10',
      :auto_aof_rewrite_min_size => '16mb',
      :slowlog_log_slower_than => 5000,
      :slowlog_max_len => 2048
    } }

    it { should contain_file('/etc/redis.conf') }
    it { should contain_file('/etc/redis.conf').with(:content => /^port\s1234$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^bind\s1\.2\.3\.4$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^unixsocket\s\/tmp\/redis\.sock$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^loglevel\sverbose$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^databases\s1$/) }
    it { should_not contain_file('/etc/redis.conf').with(:content => /^save\s900\s1$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^save\s300\s1$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^slaveof\s1\.2\.3\.5\s2345$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^masterauth\ssecretpass$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^requirepass\smypass/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^maxclients\s256$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^maxmemory\s100mb$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^maxmemory\-policy\svolatile\-random$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^appendonly\syes$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^appendfsync\salways$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^auto\-aof\-rewrite\-percentage\s10$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^auto\-aof\-rewrite\-min\-size\s16mb$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^slowlog\-log\-slower\-than\s5000$/) }
    it { should contain_file('/etc/redis.conf').with(:content => /^slowlog\-max\-len\s2048$/) }


  end

end
