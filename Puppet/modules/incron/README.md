incron
======

This incron module allows you to define incron jobs just like you would cronjobs using a resource type.

Package installation is possible by including the incron class, but not mandatory. This is to accomodate the various ways organisations manage installing packages.

As opposed to the cron resource type, incron resource names must be unique system wide.

Due to incrons inability to handle comments, it will log the following error when changes are made to an incrontab file. This error is harmless however:
access denied on # - events will be discarded silently

incron_allowuser and incron_denyuser allow for incron.allow/deny file management.

Usage Example
-------------

    include incron # Not needed if the package was installed through other means.

    incron {'test1':
      user    => 'wleese',
      command => 'touch /tmp/1',
      path    => '/home/wleese/',
      mask    => ['IN_CREATE'],
    }

    # Optional, only if you need to manage allowed users
    incron_allowuser { 'wleese':
      ensure => present,
    }

Valid values for the mask parameter are:

    IN_ACCESS
    IN_MODIFY
    IN_ATTRIB
    IN_CLOSE_WRITE
    IN_CLOSE_NOWRITE
    IN_OPEN
    IN_MOVED_FROM
    IN_MOVED_TO
    IN_CREATE
    IN_DELETE
    IN_DELETE_SELF
    IN_UNMOUNT
    IN_Q_OVERFLOW
    IN_IGNORED
    IN_CLOSE
    IN_MOVE
    IN_ISDIR
    IN_ONESHOT
    IN_ALL_EVENT
    IN_NO_LOOP

To use it with Hiera
--------------------
To pass the parameters from the hiera user include this line in your site.pp file
```
include incron::hiera_limits
```

Hiera Example:
--------------
```
incron:
  'test1':
      user_name: 'wleese'
      user_command: 'touch /tmp/1'
      user_path: '/home/wleese/'
      user_mask: 'IN_CREATE'
  'test2':
      user_name: 'ubuntu'
      user_command: 'touch /home/ubuntu/home.txt'
      user_path: '/home/ubuntu'
      user_mask: 'IN_CREATE'
      user_allow: 'ubuntu'
```
** user_allow and user_deny are optional you can user it to manage users**
