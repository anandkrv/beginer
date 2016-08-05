require 'spec_helper'
describe 'php' do

  context 'with defaults for all parameters' do
    it { should contain_class('php') }
  end
end
