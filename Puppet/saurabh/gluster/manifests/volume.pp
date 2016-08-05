class gluster::volume(
    $name = '',
    $replica_count = 1,
    $bricks = $brick_list,
    $transport_type = "tcp",
    $force ='force',
)  {  

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


    $bricks_string = inline_template("<%= @bricks.join(' ') %>")
     
    exec {'volume_create':
              command => "gluster volume create ${name} replica ${replica_count} transport ${transport_type}  ${bricks_string} ${force}",
              require => Class['gluster'],
              before  => Exec['volume_start'],
         }

    exec { 'volume_start':
              command => "gluster volume start ${name}",
         }
}

