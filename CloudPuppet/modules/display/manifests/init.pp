# == Class: display
#
# Installs and configures Xvfb and x11vnc.
#
# === Parameters
#
# [*display*]
#    X display to use. Default is 0.
# [*width*]
#    Screen width to use. Default is 1280.
# [*height*]
#    Screen height to use. Default is 800.
# [*color*]
#    Screen color depth to use. Default is "24+32" (32 bit).
# [*runuser*]
#    User to run xvfb as. Default is 'root'.
# [*fbdir*]
#    Directory in which the memory mapped files containing the framebuffer
#    memory should be created. Defaults to '/tmp'
# [*xvfb_package*]
#    Package name for installing xvfb. Defaults to 'xorg-x11-server-Xvfb' on
#    RedHat systems and 'xvfb' on Debian systems.
# [*xvfb_service*]
#    Name of the xvfb service. This class will create an initscript with this
#    name and manage a service with this name.  Defaults to 'xvfb'
# [*xvfb_bin*]
#    Absolute path to the 'xvfb' executable. Defaults to '/usr/bin/xvfb' on
#    RedHat and Debian systems and '/usr/local/bin/Xvfb' on FreeBSD.
# [*xvfb_custom_args*]
#    Custom arguments to use for starting xvfb.  If this parameter is defined,
#    the display, width, height, color, and fbdir parameter values will not
#    be used for starting the xvfb service via the init script - that's left
#    up to the user.  Optional.  Defaults to undefined.
# [*x11vnc_package*]
#    Package name for installing x11vnc. Defaults to 'x11vnc' on RedHat and
#    Debian systems.
# [*x11vnc_service*]
#    Name of the x11vnc service. This class will create an init script with
#    this name and manage a service with this name.  Defaults to 'x11vnc'
# [*x11vnc_bin*]
#    Absolute path to the 'x11vnc' executable. Defaults to '/usr/bin/x11vnc' on
#    RedHat and Debian systems and '/usr/local/bin/x11vnc' on FreeBSD.
# [*x11vnc_custom_args*]
#    Custom arguments to use for starting x11vnc.  If this parameter is defined,
#    the display parameter will be unused for x11vnc.  You'll have to pass that
#    yourself via x11vnc_custom_args.
#    Optional.  Defaults to undefined.
# [*display_env*]
#    Boolean. Provide a profile.d script to export the DISPLAY variable.
#    Defaults to true.
# [*display_env_path*]
#    Absolute path to place a profile.d script that exports the DISPLAY
#    variable.  Defaults to '/etc/profile.d/vagrant_display.sh
#    This is only effective if 'profiled' is true.
#
# === Examples
#
#  class { 'display':
#    display => 99,
#    width   => 1024,
#    height  => 768,
#    color   => 24,
#  }
#
# === Authors
#
# Joshua Beard <beard@puppetlabs.com>
# Alex Rodionov <p0deje@gmail.com>
# Joshua Hoblitt <jhoblitt@cpan.org>
#
# === Copyright
#
# Copyright (C) 2013-2014 Joshua Beard <beard@puppetlabs.com>
# Copyright (C) 2013-2014 Alex Rodionov <p0deje@gmail.com>
# Copyright (C) 2012-2014 Joshua Hoblitt <jhoblitt@cpan.org>
#
class display (
  $display            = $display::params::display,
  $width              = $display::params::width,
  $height             = $display::params::height,
  $color              = $display::params::color,
  $runuser            = $display::params::runuser,
  $fbdir              = $display::params::fbdir,
  $xvfb_package       = $display::params::xvfb_package_name,
  $xvfb_service       = $display::params::xvfb_service_name,
  $xvfb_bin           = $display::params::xvfb_bin,
  $xvfb_custom_args   = undef,
  $x11vnc_package     = $display::params::x11vnc_package_name,
  $x11vnc_service     = $display::params::x11vnc_service_name,
  $x11vnc_bin         = $display::params::x11vnc_bin,
  $x11vnc_custom_args = undef,
  $display_env        = true,
  $display_env_path   = undef,
) inherits display::params {
  require stdlib
  validate_integer($display)
  validate_integer($width)
  validate_integer($height)
  validate_re($color, '\d{2}\+\d{2}')
  validate_string($runuser)
  validate_absolute_path($fbdir)
  validate_string($xvfb_package)
  validate_string($xvfb_service)
  validate_absolute_path($xvfb_bin)
  validate_string($x11vnc_package)
  validate_string($x11vnc_service)
  validate_absolute_path($x11vnc_bin)
  validate_bool($display_env)

  if $xvfb_custom_args {
    validate_string($xvfb_custom_args)
  }

  if $x11vnc_custom_args {
    validate_string($x11vnc_custom_args)
  }

  if $display_env_path {
    validate_absolute_path($display_env_path)
  }

  if $display_env {
    class { 'display::env':
      display => $display,
      file    => $display_env_path,
    }
  }

  class { 'display::xvfb':
    display     => $display,
    width       => $width,
    height      => $height,
    color       => $color,
    runuser     => $runuser,
    fbdir       => $fbdir,
    package     => $xvfb_package,
    service     => $xvfb_service,
    xvfb_bin    => $xvfb_bin,
    custom_args => $xvfb_custom_args,
  }

  class { 'display::x11vnc':
    display     => $display,
    x11vnc_bin  => $x11vnc_bin,
    package     => $x11vnc_package,
    service     => $x11vnc_service,
    custom_args => $x11vnc_custom_args,
  }

  Class['display::xvfb'] -> Class['display::x11vnc']
}
