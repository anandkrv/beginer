require 'spec_helper'

describe 'memcached::package' do
  it { should contain_package('memcached') }
end
