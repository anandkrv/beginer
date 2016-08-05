# == Class: display::env
#
# Exports DISPLAY variable.
#
# NOTE: This class is being deprecated and is pending removal!
#       The management of the DISPLAY environment variable should be managed
#       elsewhere.
#
# === Parameters
# [*file*]
#   Absolute path to place the environment file, which exports DISPLAY.
#   Defaults to /etc/profile.d/vagrant_display.sh
# [*display*]
#   X display to use.  Defaults to 0.
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
class display::env (
  $file    = '/etc/profile.d/vagrant_display.sh',
  $display = $display::params::display,
) inherits display::params {
  validate_absolute_path($file)
  validate_integer($display)

  notice('The display::env class is deprecated and is pending removal. Please use another method to manage the DISPLAY environment variable.')

  concat { $file:
    owner => root,
    group => root,
    mode  => '0644',
  }

  concat::fragment { 'DISPLAY':
    target  => $file,
    content => "export DISPLAY=:${display}",
  }
}
