require 'spec_helper'
describe 'glus' do

  context 'with defaults for all parameters' do
    it { should contain_class('glus') }
  end
end
