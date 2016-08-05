require 'spec_helper'
describe 'percona' do

  context 'with defaults for all parameters' do
    it { should contain_class('percona') }
  end
end
