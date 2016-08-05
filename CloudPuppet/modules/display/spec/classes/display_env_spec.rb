require 'spec_helper'

describe 'display::env', :type => :class do
  let(:facts) {{
    :osfamily       => 'RedHat',
    :concat_basedir => '/tmp',
  }}
  context 'when called with default parameters' do
    it do
      should contain_concat('/etc/profile.d/vagrant_display.sh')
      should contain_concat__fragment('DISPLAY').with({
        :target => '/etc/profile.d/vagrant_display.sh',
      })
      should contain_concat__fragment('DISPLAY').with_content(
        'export DISPLAY=:0'
      )
    end
  end

  context 'when called with custom parameters' do
    let(:params) {{
      :file    => '/etc/something.sh',
      :display => 21,
    }}
    it do
      should contain_concat('/etc/something.sh')
      should contain_concat__fragment('DISPLAY').with({
        :target => '/etc/something.sh',
      })
      should contain_concat__fragment('DISPLAY').with_content(
        'export DISPLAY=:21'
      )
    end
  end

  context 'when called with invalid params' do
    describe 'not an absolute path' do
      let(:params) {{ :file => 'blah' }}
      it 'should fail when file is not an absolute path' do
        should raise_error(Puppet::Error, /"blah" is not an absolute path/)
      end
    end
    describe 'display is not an integer' do
      let(:params) {{ :display => 'halb' }}
      it 'should fail when its not an integer' do
        should raise_error(Puppet::Error)
      end
    end
  end
end
