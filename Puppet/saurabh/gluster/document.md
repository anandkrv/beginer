## create a file filename.pp in puppet/manifest and use below blocks as per your requirement.
#### Use gluster class for installing glusterfs-server.


   class { 'gluster':}


#####################################################################################################

#### Use peers class to add peears.

   class {"gluster::peers":
           peers => [],
         } 

######################################################################################################

#### Use volume class to create a volume.


   $brick_list = [
                   '192.168.1.9:/data/glusternew4',
                   '192.168.1.10:/data/glustenew4',
                 ] 

   class{"gluster::volume":
           name => "volname4",
           replica_count => 2,
           bricks => $brick_list,
        } 

#######################################################################################################

#### Use client class to setup a client


class {"gluster::client":
$server = '192.168.1.9',
$volume = 'testvol',
$mount_point = '/mnt/gluster1',
}


#########################################################################################################

