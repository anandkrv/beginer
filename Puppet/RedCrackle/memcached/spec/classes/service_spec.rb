require 'spec_helper'

describe 'memcached::service' do
  it { should contain_service('memcached') }
end
