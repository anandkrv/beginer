class{'sftpjail':
  user_pass => ['ops1:ops123', 'ops2:ops1234'], 
  homedir => '/incoming',
  group_name => 'sftpgroup'
}
