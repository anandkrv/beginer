require 'spec_helper'

describe 'display::x11vnc', :type => :class do

  describe 'compiles with default parameters' do
    ['Debian', 'RedHat', 'FreeBSD'].each do |system|
      context "#{system}" do
        let(:facts) {{ :osfamily => system }}
        it do
          should contain_package('x11vnc').with({
            :name => 'x11vnc',
          })

          should contain_service('x11vnc').with({
            :name => 'x11vnc',
          })
        end
      end
    end

    describe 'creates proper init script' do
      ['Debian','RedHat'].each do |system|
        context "on #{system}" do
          let(:facts) {{ :osfamily => system }}
          it do
            should contain_file('x11vnc-init').with({
              :path => '/etc/init.d/x11vnc',
            })
            should contain_file('x11vnc-init').with_content(
              /^DISPLAY=":0"$/
            )
          end
        end
      end

      context 'on RedHat' do
        let(:facts) {{ :osfamily => 'RedHat' }}
        it do
          should contain_file('x11vnc-init').with_content(
            /^exec="\/usr\/bin\/x11vnc"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^\s+daemon --user 'root'\s/
          )
        end
      end

      context 'on Debian' do
        let(:facts) {{ :osfamily => 'Debian' }}
        it do
          should contain_file('x11vnc-init').with_content(
            /^BINARY=\/usr\/bin\/x11vnc$/
          )
          should contain_file('x11vnc-init').with_content(
            /^PIDFILE=\/var\/run\/x11vnc\.pid$/
          )
          should contain_file('x11vnc-init').with_content(
            /^\s+start-stop-daemon.*--chuid root\s/
          )
          should contain_file('x11vnc-init').with_content(
            /^\s+status_of_proc.*x11vnc\s/
          )
        end
      end

      context 'on FreeBSD' do
        let(:facts) {{ :osfamily => 'FreeBSD' }}
        it do
          should contain_file('x11vnc-init').with({
            :path => '/usr/local/etc/rc.d/x11vnc',
          })
          should contain_file('x11vnc-init').with_content(
            /^name="x11vnc"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^rcvar="x11vnc_enable"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^command="\/usr\/local\/bin\/x11vnc"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^command_args="-forever -display :0"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^pidfile="\${x11vnc_rundir}\/x11vnc\.pid"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^\s+\/usr\/sbin\/daemon -u root\s/
          )
        end
      end

    end
  end

  context 'with custom parameters' do
    let(:facts) {{ :osfamily => 'RedHat' }}
    let(:params) {{
      :display    => 21,
      :x11vnc_bin => '/usr/local/bin/myx11vnc',
      :package    => 'myx11vnc',
      :service    => 'x11vnccustom',
      :runuser    => 'reznor',
    }}
    it do
      should contain_package('x11vnc').with({ :name => 'myx11vnc' })
      should contain_service('x11vnc').with({ :name => 'x11vnccustom' })
    end

    describe 'create proper init script path' do
      ['Debian','RedHat'].each do |system|
        context "on #{system}" do
          let(:facts) {{ :osfamily => system }}
          it do
            should contain_file('x11vnc-init').with({
              :path => '/etc/init.d/x11vnccustom',
            })
          end
        end
        context 'on FreeBSD' do
          let(:facts) {{ :osfamily => 'FreeBSD' }}
          it do
            should contain_file('x11vnc-init').with({
              :path => '/usr/local/etc/rc.d/x11vnccustom',
            })
          end
        end
      end
    end

    describe 'create proper init script contents' do
      context 'on RedHat' do
        let(:facts) {{ :osfamily => 'RedHat' }}
        it do
          should contain_file('x11vnc-init').with_content(
            /^exec="\/usr\/local\/bin\/myx11vnc"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^\s+daemon --user 'reznor'\s/
          )
        end

        context 'with custom_args' do
          let(:params) {{ :custom_args => 'FOO BAR BAZ' }}
          it do
            should contain_file('x11vnc-init').with_content(
              /^ARGS="FOO BAR BAZ"$/
            )
          end
        end
      end

      context 'on Debian' do
        let(:facts) {{ :osfamily => 'Debian' }}
        it do
          should contain_file('x11vnc-init').with_content(
            /^BINARY=\/usr\/local\/bin\/myx11vnc$/
          )
          should contain_file('x11vnc-init').with_content(
            /^PIDFILE=\/var\/run\/x11vnccustom\.pid$/
          )
          should contain_file('x11vnc-init').with_content(
            /^\s+start-stop-daemon.*--chuid reznor\s/
          )
          should contain_file('x11vnc-init').with_content(
            /^\s+status_of_proc.*x11vnccustom\s/
          )
        end
        context 'with custom_args' do
          let(:params) {{ :custom_args => 'FOO BAR BAZ' }}
          it do
            should contain_file('x11vnc-init').with_content(
              /^ARGS="FOO BAR BAZ"$/
            )
          end
        end
      end

      context 'on FreeBSD' do
        let(:facts) {{ :osfamily => 'FreeBSD' }}
        it do
          should contain_file('x11vnc-init').with({
            :path => '/usr/local/etc/rc.d/x11vnccustom',
          })
          should contain_file('x11vnc-init').with_content(
            /^name="x11vnccustom"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^rcvar="x11vnccustom_enable"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^command="\/usr\/local\/bin\/myx11vnc"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^command_args="-forever -display :21"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^pidfile="\${x11vnccustom_rundir}\/x11vnccustom\.pid"$/
          )
          should contain_file('x11vnc-init').with_content(
            /^\s+\/usr\/sbin\/daemon -u reznor\s/
          )
        end

        context 'with custom_args' do
          let(:params) {{ :custom_args => 'FOO BAR BAZ' }}
          it do
            should contain_file('x11vnc-init').with_content(
              /^command_args="FOO BAR BAZ"$/
            )
          end
        end

      end
    end
  end

  context 'should fail when invalid parameters are passed' do
    let(:facts) {{ :osfamily => 'RedHat' }}
    describe 'display' do
      let(:params) {{ :display => 'dstring' }}
      it 'should fail when its not an integer' do
        should raise_error(Puppet::Error)
      end
    end
    describe 'x11vnc_bin' do
      let(:params) {{ :x11vnc_bin => 'myx11vncbin' }}
      it 'should fail when x11vnc_bin is not an absolute path' do
        should raise_error(Puppet::Error, /"myx11vncbin" is not an absolute path/)
      end
    end
    describe 'service' do
      let(:params) {{ :service => ['one'] }}
      it 'should fail when service is not a string' do
        should raise_error(
          Puppet::Error, /\["one"\] is not a string/
        )
      end
    end
    describe 'runuser' do
      let(:params) {{ :runuser => ['reznor'] }}
      it 'should fail when runuser is not a string' do
        should raise_error(
          Puppet::Error, /\["reznor"\] is not a string/
        )
      end
    end
  end
end
