## create a file filename.pp in puppet/manifest and use following piece of code.

class{'sftpjail':

                 user_pass => ['usernam1:password1', 'username2:password2'], ## ':' sapareted username and password

                 homedir => '/homedirectory',                                ## home directiory for user

                 group_name => 'sftpgroupname'                               ##  group for sftp users

}

