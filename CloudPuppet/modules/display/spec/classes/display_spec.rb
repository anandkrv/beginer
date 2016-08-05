require 'spec_helper'

describe 'display', :type => :class do
  context 'when called with default parameters' do
    context 'on RedHat' do
      let(:facts) {
        {
          :osfamily       => 'RedHat',
          :concat_basedir => '/tmp',
        }
      }
      it do
        should contain_class('display::xvfb').with({
          'display'  => 0,
          'width'    => 1280,
          'height'   => 800,
          'color'    => '24+32',
          'runuser'  => 'root',
          'fbdir'    => '/tmp',
          'package'  => 'xorg-x11-server-Xvfb',
          'service'  => 'xvfb',
          'xvfb_bin' => '/usr/bin/Xvfb',
        })
        should contain_class('display::x11vnc').with({
          'display'    => 0,
          'x11vnc_bin' => '/usr/bin/x11vnc',
          'package'    => 'x11vnc',
          'service'    => 'x11vnc',
        })
        should contain_class('display::env').with({
          'display' => 0,
          'file'    => '/etc/profile.d/vagrant_display.sh',
        })

      end
    end
    context 'on Debian' do
      let(:facts) {
        {
          :osfamily       => 'Debian',
          :concat_basedir => '/tmp',
        }
      }
      it do
        should contain_class('display::xvfb').with({
          'package'  => 'xvfb',
          'xvfb_bin' => '/usr/bin/Xvfb',
        })
        should contain_class('display::x11vnc').with({
          'display'    => 0,
          'x11vnc_bin' => '/usr/bin/x11vnc',
          'package'    => 'x11vnc',
        })
      end
    end

    context 'on FreeBSD' do
      let(:facts) {
        {
        :osfamily       => 'FreeBSD',
        :concat_basedir => '/tmp',
      }
      }
      it do
        should contain_class('display::xvfb').with({
          'package'  => 'xorg-vfbserver',
          'xvfb_bin' => '/usr/local/bin/Xvfb',
        })
        should contain_class('display::x11vnc').with({
          'display'    => 0,
          'x11vnc_bin' => '/usr/local/bin/x11vnc',
          'package'    => 'x11vnc',
        })
        should contain_class('display::env').with({
          'display' => 0,
          'file'    => '/etc/profile.d/vagrant_display.sh',
        })
      end
    end
  end

  context 'when called with custom parameters' do
    context 'on RedHat' do
      let(:facts) {
        {
          :osfamily       => 'RedHat',
          :concat_basedir => '/tmp',
        }
      }

      let(:params) {
        {
          :display            => 30,
          :width              => 1024,
          :height             => 768,
          :color              => '16+24',
          :runuser            => 'test',
          :fbdir              => '/tmp/fbdir',
          :xvfb_package       => 'xvfb_testpkg',
          :xvfb_service       => 'xvfb_testsvc',
          :xvfb_bin           => '/usr/bin/xvfb_testbin',
          :xvfb_custom_args   => 'FOO BAR BAZ',
          :x11vnc_package     => 'x11vnc_testpkg',
          :x11vnc_service     => 'x11vnc_testsvc',
          :x11vnc_bin         => '/usr/bin/x11vnc_testbin',
          :x11vnc_custom_args => 'FOO BAR BAZ',
        }
      }

      it do
        should contain_class('display::xvfb').with({
          'display'     => 30,
          'width'       => 1024,
          'height'      => 768,
          'color'       => '16+24',
          'runuser'     => 'test',
          'fbdir'       => '/tmp/fbdir',
          'package'     => 'xvfb_testpkg',
          'service'     => 'xvfb_testsvc',
          'xvfb_bin'    => '/usr/bin/xvfb_testbin',
          'custom_args' => 'FOO BAR BAZ',
        })
        should contain_class('display::x11vnc').with({
          'display'     => 30,
          'x11vnc_bin'  => '/usr/bin/x11vnc_testbin',
          'package'     => 'x11vnc_testpkg',
          'service'     => 'x11vnc_testsvc',
          'custom_args' => 'FOO BAR BAZ',
        })
      end
    end

    context 'without display_env' do
      let(:facts) {
        {
          :osfamily       => 'RedHat',
          :concat_basedir => '/tmp',
        }
      }
      let (:params) {{ :display_env => false, }}
      it { should_not contain_class('display::env') }
    end

    context 'with custom display_env_path' do
      let(:facts) {
        {
          :osfamily       => 'RedHat',
          :concat_basedir => '/tmp',
        }
      }
      let (:params) {{
        :display_env      => true,
        :display_env_path => '/tmp/display.sh',
      }}
      it do should contain_class('display::env').with({
        :file => '/tmp/display.sh',
      })
      end
    end
  end

  context 'on an unsupported osfamily' do
    let(:facts) {{ :osfamily => 'Windows' }}
    it 'should fail when osfamily is windows' do
      should raise_error(
        Puppet::Error, /Module display is not supported on Windows/
      )
    end
  end

end
