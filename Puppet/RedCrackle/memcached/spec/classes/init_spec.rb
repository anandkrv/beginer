require 'spec_helper'

describe 'memcached' do
  it { should contain_class('memcached::package') }
  it { should contain_class('memcached::config') }
  it { should contain_class('memcached::service') }
end
