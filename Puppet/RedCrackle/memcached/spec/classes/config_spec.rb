require 'spec_helper'

describe 'memcached::config' do
  it { should contain_file('/etc/default/memcached') }
  it { should contain_file('/etc/memcached.conf') }
end
