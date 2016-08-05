 put hiera.yaml file and hieradata folder in your /etc/puppet/ folder 
 configure hiera.yaml according to your requirement
 put the key value pairs in correspondig .yaml file in hiradata folder(for example common.yaml)
 use that data in your manifest.pp file 

 example for a.pp  

 class{'sftpjail':}
