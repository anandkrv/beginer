class gluster::client(
$server = '',
$volume = '',
$mount_point = '',
)
{

      package { 'glusterfs-client':
             ensure => installed,
             notify => Service[ 'glusterfs-client' ],
             }

      service { 'glusterfs-client':
               ensure => running,
               enable => true,
              }

      file { "${mount_point}": 
             ensure => directory, # make sure this is a directory
             recurse => false, # don't recurse into directory
             purge => false, # don't purge unmanaged files
             force => false, # don't purge subdirs and links
             require => Service['glusterfs-client'],
           }
       Exec {
       path => [
               '/usr/local/bin',
               '/opt/local/bin',
               '/usr/bin',
               '/usr/sbin',
               '/bin',
               '/sbin'],
               logoutput => true,
        }

       exec {'mount_volume':
              command => "mount -t glusterfs  ${server}:${volume}  ${mount_point}",
              require  => File['${mount_point}'],
         }
     
}
