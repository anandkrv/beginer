# puppet-display

[![Build Status](https://img.shields.io/travis/joshbeard/puppet-display.svg?style=flat-square)](https://travis-ci.org/joshbeard/puppet-display)

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with display](#setup)
    * [What display affects](#what-display-affects)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - classes and parameters](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Contributors](#contributors)

## Overview

The display module can manage Xvfb (X Virtual Framebuffer) and x11vnc for
remote displays.

The base class, `display`, can be used to manage both `xvfb` and `x11vnc`
together.

`xvfb` and `x11vnc` can be managed individually using their own classes if
desired.

Additionally, a profile.d helper script can be managed that exports the
`DISPLAY` environment variable.

## Setup

### What display affects

The __display__ module can manage the following:

* xvfb package
* xvfb service
* x11vnc package
* x11vnc service

## Usage

__To manage `xvfb` and `x11vnc` with default parameters:__

```puppet
include ::display
```

__Custom display, resolution and color depth:__

```puppet
class { 'display':
  display => 99,   # default is 0
  width   => 1024, # default is 1280
  height  => 768,  # default is 800
  color   => 24,   # default is "24+32" (i.e. 32-bit)
}
```

__Running as a custom user (both xvfb and x11vnc):__

```puppet
class { 'display':
  runuser => 'xvfbservice',
}
```

__Only manage _xvfb_ (e.g. not x11vnc) and specify a custom user and fbdir:__

```puppet
class { 'display::xvfb':
  runuser => 'xvfbuser',
  fbdir   => '/var/tmp/xvfb',
}
```

__Only manage _x11vnc_:__

```puppet
class { 'display::x11vnc':
  display => 3,
  runuser => 'x11user',
}
```

## Reference

### Classes

* __display:__ Main class, includes all other classes (wrapper)
* __display::xvfb:__ Manages _xvfb_
* __display::x11vnc:__ Manages _x11vnc_

#### Class: display

##### `display`

  X display to use. Default is `0`

#### `width`

  Screen width to use. Default is `1280`

#### `height`

  Screen height to use. Default is `800`

#### `color`

  Screen color depth to use. Default is `'24+32'` (32-bit)

#### `runuser`

  User to run xvfb as. Default is `'root'`

#### `fbdir`

  Directory in which the memory mapped files containing the framebuffer memory
  should be created. Defaults to `'/tmp'`

#### `xvfb_package`

  Package name for installing xvfb. Defaults to `xorg-x11-servers-Xvfb` on
  RedHat systems and `xvfb` on Debian systems.

#### `xvfb_service`

  Name of the xvfb service.  This class will create an init script with this
  name and manage a service by this name.  Defaults to `xvfb`

#### `xvfb_bin`

  Absolute path to the `xvfb` executable. Defaults to `/usr/bin/xvfb` on
  RedHat and Debian systems and `/usr/local/bin/Xvfb` on FreeBSD.

#### `xvfb_custom_args`

  Custom arguments to use for starting xvfb.  If this parameter is defined,
  the display, width, height, color, and fbdir parameter values will not
  be used for starting the xvfb service via the init script - that's left
  up to the user.  Optional.  Defaults to undefined.

#### `x11vnc_package`

  Package name for installing x11vnc. Defaults to `x11vnc` on RedHat and
  Debian systems.

#### `x11vnc_service`

  Name of the x11vnc service. This class will create an init script with
  this name and manage a service with this name.  Defaults to `x11vnc`

#### `x11vnc_bin`

  Absolute path to the `x11vnc` executable. Defaults to `/usr/bin/x11vnc` on
  RedHat and Debian systems and `/usr/local/bin/x11vnc` on FreeBSD.

#### `x11vnc_custom_args`

  Custom arguments to use for starting x11vnc.  If this parameter is defined,
  the display parameter is unused for starting x11vnc - that's left up to the
  user.
  Optional.  Defaults to undefined.

#### `display_env`

  Boolean. Provide a profile.d script to export the `DISPLAY` variable.
  Defaults to `true`.

  __NOTE:__ This parameter and the display::env class is being deprecated and
  will soon be removed.

#### `display_env_path`
  Absolute path to place a profile.d script that exports the `DISPLAY`
  variable.  Defaults to `/etc/profile.d/vagrant_display.sh`
  This is only effective if 'profiled' is `true`.

  __NOTE:__ This parameter and the display::env class is being deprecated and
  will soon be removed.

#### Class: display::xvfb

#### `display`

  X display to use. Default is `0`

#### `width`

  Screen width to use. Default is `1280`

#### `height`

  Screen height to use. Default is `800`

#### `color`

  Screen color depth to use. Default is `'24+32'` (32-bit)

#### `runuser`

  User to run xvfb as. Default is `'root'`

#### `fbdir`

  Directory in which the memory mapped files containing the framebuffer memory
  should be created. Defaults to `'/tmp'`

#### `package`

  Package name for installing xvfb. Defaults to `xorg-x11-servers-Xvfb` on
  RedHat systems and `xvfb` on Debian systems.

#### `custom_args`

  Custom arguments to use for starting xvfb.  If this parameter is defined,
  the display, width, height, color, and fbdir parameter values will not
  be used for starting the xvfb service via the init script - that's left
  up to the user.  Optional.  Defaults to undefined.

#### `service`

  Name of the xvfb service.  This class will create an init script with this
  name and manage a service by this name.  Defaults to `xvfb`

#### Class: display::x11vnc

#### `display`

  X display to use. Default is `0`

#### `runuser`

  User to run xvfb as. Default is `'root'`

#### `package`

  Package name for installing x11vnc. Defaults to `x11vnc` on RedHat and
  Debian systems.

#### `service`

  Name of the x11vnc service. This class will create an init script with
  this name and manage a service with this name.  Defaults to `x11vnc`

#### `x11vnc_bin`

  Absolute path to the `x11vnc` executable. Defaults to `/usr/bin/x11vnc` on
  RedHat and Debian systems and `/usr/local/bin/x11vnc` on FreeBSD.

#### `custom_args`

  Custom arguments to use for starting x11vnc.  If this parameter is defined,
  the display parameter is unused for starting x11vnc - that's left up to the
  user.
  Optional.  Defaults to undefined.

#### Class: display::env

__NOTE:__ This class is being deprecated and will soon be removed.

This is better managed by your own implementation class.  For example, a
_profile_ class.

#### `file`

  Absolute path where a file should be place that exports the DISPLAY
  environment variable. Defaults to `/etc/profile.d/vagrant_display.sh`

#### `display`

  X display to use. Default is `0`

## Limitations

This module has been built on a tested against Puppet 3.

Supported and tested on RedHat, Debian, and FreeBSD families.

## Contributors

Alex Rodionov [https://github.com/p0deje](https://github.com/p0deje)

Josh Beard [http://joshbeard.me](http://joshbeard.me)

Joshua Hoblitt [https://github.com/jhoblitt](https://github.com/jhoblitt)

### License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  [http://www.apache.org/licenses/LICENSE-2.](0http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
