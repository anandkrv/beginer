require 'spec_helper'
describe 'ssh_key' do

  context 'with defaults for all parameters' do
    it { should contain_class('ssh_key') }
  end
end
