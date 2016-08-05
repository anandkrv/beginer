# == Class: display::params
#
# Display parameters. Private class.
#
# === Authors
#
# Joshua Beard <beard@puppetlabs.com>
# Joshua Hoblitt <jhoblitt@cpan.org>
#
# === Copyright
#
# Copyright (C) 2013-2014 Joshua Beard <beard@puppetlabs.com>
# Copyright (C) 2013-2014 Alex Rodionov <p0deje@gmail.com>
# Copyright (C) 2012-2014 Joshua Hoblitt <jhoblitt@cpan.org>
#
class display::params {
  $lc_osfamily         = downcase($::osfamily)
  $x11vnc_package_name = 'x11vnc'
  $x11vnc_service_name = 'x11vnc'
  $xvfb_erb            = "display/${lc_osfamily}/xvfb.erb"
  $x11vnc_erb          = "display/${lc_osfamily}/x11vnc.erb"
  $xvfb_service_name   = 'xvfb'
  $display             = '0'
  $width               = '1280'
  $height              = '800'
  $color               = '24+32'
  $runuser             = 'root'
  $fbdir               = '/tmp'

  case $::osfamily {
    'redhat': {
      $xvfb_package_name = 'xorg-x11-server-Xvfb'
      $xvfb_bin          = '/usr/bin/Xvfb'
      $x11vnc_bin        = '/usr/bin/x11vnc'
      $init_path         = '/etc/init.d'
    }
    'debian': {
      $xvfb_package_name = 'xvfb'
      $xvfb_bin          = '/usr/bin/Xvfb'
      $x11vnc_bin        = '/usr/bin/x11vnc'
      $init_path         = '/etc/init.d'
    }
    'freebsd': {
      $xvfb_package_name = 'xorg-vfbserver'
      $xvfb_bin          = '/usr/local/bin/Xvfb'
      $x11vnc_bin        = '/usr/local/bin/x11vnc'
      $init_path         = '/usr/local/etc/rc.d'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
  }
}
