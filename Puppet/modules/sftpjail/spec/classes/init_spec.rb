require 'spec_helper'
describe 'sftpjail' do

  context 'with defaults for all parameters' do
    it { should contain_class('sftpjail') }
  end
end
