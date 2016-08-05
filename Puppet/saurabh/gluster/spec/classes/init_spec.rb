require 'spec_helper'
describe 'gluster' do

  context 'with defaults for all parameters' do
    it { should contain_class('gluster') }
  end
end
