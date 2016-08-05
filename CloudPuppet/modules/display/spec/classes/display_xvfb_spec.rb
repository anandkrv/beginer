require 'spec_helper'

describe 'display::xvfb', :type => :class do

  context 'with default parameters' do

    ['Debian', 'RedHat'].each do |system|
      context "on #{system}" do
        let(:facts) {{ :osfamily => system }}
        it do
          should contain_file('xvfb-init').with({
            'path'    => '/etc/init.d/xvfb',
          })
          should contain_service('xvfb').with({
            'name' => 'xvfb',
          })

          should contain_file('xvfb-init').with_content(/^DISPLAY=":0"$/)
          should contain_file('xvfb-init').with_content(/^WIDTH=1280$/)
          should contain_file('xvfb-init').with_content(/^HEIGHT=800$/)
          should contain_file('xvfb-init').with_content(/^COLOR=24\+32$/)
          should contain_file('xvfb-init').with_content(/^.*-fbdir \/tmp.*$/)
        end
      end
    end

    context 'on RedHat' do
      let(:facts) {{ :osfamily => 'RedHat' }}
      it do
        should contain_package('xvfb').with({
          'name' => 'xorg-x11-server-Xvfb',
        })

        should contain_file('xvfb-init').with_content(
          /^exec="\/usr\/bin\/Xvfb"$/
        )
        should contain_file('xvfb-init').with_content(/^\s+daemon --user 'root'/)
      end
    end

    context 'on Debian' do
      let(:facts) {{ :osfamily => 'Debian' }}
      it do
        should contain_package('xvfb').with({
          'name' => 'xvfb',
        })

        should contain_file('xvfb-init').with_content(/^XVFB=\/usr\/bin\/Xvfb$/)
        should contain_file('xvfb-init').with_content(
          /^\s+start-stop-daemon.*--chuid root/
        )
        should contain_file('xvfb-init').with_content(
          /^\s+start-stop-daemon.*--user root/
        )
      end
    end

    context 'on FreeBSD' do
      let(:facts) {{ :osfamily => 'FreeBSD' }}
      it do
        should contain_package('xvfb').with({
          'name' => 'xorg-vfbserver',
        })
        should contain_file('xvfb-init').with({
          'path'    => '/usr/local/etc/rc.d/xvfb',
        })
        should contain_service('xvfb').with({
          'name' => 'xvfb',
        })

        should contain_file('xvfb-init').with_content(/^# PROVIDE: xvfb$/)
        should contain_file('xvfb-init').with_content(
          /^pidfile="\${xvfb_rundir}\/xvfb\.pid"$/
        )
        should contain_file('xvfb-init').with_content(
          /^command="\/usr\/local\/bin\/Xvfb"$/
        )
        should contain_file('xvfb-init').with_content(
          /^command_args=":0.*-fbdir \/tmp .* 1280x800x24\+32"$/
        )
      end
    end
  end

  context 'custom package name' do
    let(:facts) {{ :osfamily => 'FreeBSD', }}
    let(:params) {{ :package => 'xvfb-custom-pkgname' }}
    it do
      should contain_package('xvfb').with({
        'name' => 'xvfb-custom-pkgname',
      })
    end
  end

  context 'custom service name' do
    let(:facts) {{ :osfamily => 'FreeBSD' }}
    let(:params) {{ :service => 'xvfb-custom-svcname' }}
    it do
      should contain_service('xvfb').with({
        'name' => 'xvfb-custom-svcname',
      })
    end
  end

  describe 'creates proper init script with custom params' do
    let(:params) {{
      :display  => 21,
      :width    => 1024,
      :height   => 768,
      :color    => '16+16',
      :fbdir    => '/awesome',
      :runuser  => 'reznor',
      :service  => 'xvfbcustom',
      :xvfb_bin => '/usr/local/myxvfb',
    }}
    ['Debian','RedHat'].each do |system|
      context "on #{system}" do
        let(:facts) {{ :osfamily => system }}
        context 'custom display' do
          it { should contain_file('xvfb-init').with_content(/^DISPLAY=":21"$/) }
        end
        context 'custom width' do
          it { should contain_file('xvfb-init').with_content(/^WIDTH=1024$/) }
        end
        context 'custom height' do
          it { should contain_file('xvfb-init').with_content(/^HEIGHT=768$/) }
        end
        context 'custom color' do
          it { should contain_file('xvfb-init').with_content(/^COLOR=16\+16$/) }
        end
        context 'default arguments' do
          it { should contain_file('xvfb-init').with_content(/^ARGS=\"\$DISPLAY -nolisten tcp -fbdir \/awesome -screen 0 \${WIDTH}x\${HEIGHT}x\${COLOR}\"$/) }
        end
        context 'custom arguments' do
          let(:params) {{
            :custom_args => 'FOO BAR BAZ',
          }}
          it { should contain_file('xvfb-init').with_content(/^ARGS="FOO BAR BAZ"$/) }
        end

        it do should contain_file('xvfb-init').with({
          :path => '/etc/init.d/xvfbcustom',
        })
        end

        if system == 'RedHat'
          context 'custom runuser' do
            it { should contain_file('xvfb-init').with_content(
              /^\s+daemon --user 'reznor'\s/
            )}
          end
          context 'custom xvfb_bin' do
            it { should contain_file('xvfb-init').with_content(
              /^exec="\/usr\/local\/myxvfb"$/
            )}
          end
        else
          context 'custom runuser' do
            it { should contain_file('xvfb-init').with_content(
              /^\s+start-stop-daemon.*--chuid reznor\s/
            )}
            it { should contain_file('xvfb-init').with_content(
              /^\s+start-stop-daemon.*--user reznor\s/
            )}
          end
          context 'custom xvfb_bin' do
            it { should contain_file('xvfb-init').with_content(
              /^XVFB=\/usr\/local\/myxvfb$/
            )}
          end
        end
      end
    end

    context 'on FreeBSD' do
      let(:facts) {{ :osfamily => 'FreeBSD' }}
      it do should contain_file('xvfb-init').with({
        :path => '/usr/local/etc/rc.d/xvfbcustom',
      })
      end
      context 'custom display, width, height, color, fbdir' do
        it { should contain_file('xvfb-init').with_content(
          /^command_args=":21 -nolisten tcp -fbdir \/awesome -screen 0 1024x768x16\+16"$/
        )}
      end
      context 'custom arguments' do
        let(:params) {{
          :custom_args => 'FOO BAR BAZ',
        }}
        it { should contain_file('xvfb-init').with_content(
          /^command_args="FOO BAR BAZ"$/
        )}
      end
      context 'custom xvfb_bin' do
        it { should contain_file('xvfb-init').with_content(
          /^command="\/usr\/local\/myxvfb"/
        )}
      end
      context 'custom service name' do
        it { should contain_file('xvfb-init').with_content(
          /^name="xvfbcustom"$/
        )}
        it { should contain_file('xvfb-init').with_content(
          /^pidfile="\${xvfbcustom_rundir}\/xvfbcustom\.pid"$/
        )}
      end
      context 'custom runuser' do
        it { should contain_file('xvfb-init').with_content(
          /^\s+\/usr\/sbin\/daemon -u reznor\s/
        )}
      end
    end
  end

  describe 'should fail when invalid parameters are passed' do
    let(:facts) {{ :osfamily => 'RedHat' }}
    context 'display' do
      let(:params) {{ :display => 'dstring' }}
      it 'should fail when its not an integer' do
        should raise_error(Puppet::Error)
      end
    end
    context 'width' do
      let(:params) {{ :width => 'dwidth' }}
      it 'should fail when width is not an integer' do
        should raise_error(Puppet::Error)
      end
    end
    context 'height' do
      let(:params) {{ :height => 'dheight' }}
      it 'should fail when height is not an integer' do
        should raise_error(Puppet::Error)
      end
    end
    context 'color (x not +)' do
      let(:params) {{ :color => '16x16' }}
      it 'should fail when height is not an integer' do
        should raise_error(Puppet::Error, /"16x16" does not match/)
      end
    end
    context 'fbdir' do
      let(:params) {{ :fbdir => 'awesome' }}
      it 'should fail when fbdir is not an absolute path' do
        should raise_error(Puppet::Error, /"awesome" is not an absolute path/)
      end
    end
    context 'xvfb_bin' do
      let(:params) {{ :xvfb_bin => 'myxvfbin' }}
      it 'should fail when xvfb_bin is not an absolute path' do
        should raise_error(Puppet::Error, /"myxvfbin" is not an absolute path/)
      end
    end
    context 'service' do
      let(:params) {{ :service => ['one'] }}
      it 'should fail when service is not a string' do
        should raise_error(
          Puppet::Error, /\["one"\] is not a string/
        )
      end
    end
    context 'runuser' do
      let(:params) {{ :runuser => ['reznor'] }}
      it 'should fail when runuser is not a string' do
        should raise_error(
          Puppet::Error, /\["reznor"\] is not a string/
        )
      end
    end
  end
end
