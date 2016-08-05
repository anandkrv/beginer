Workstation setup have couple of dependency
1.) Server setup should be done with User & Organization creation
2.) You need to download the Client key i.e sandeep.pem in our case
3.) You need to download the Organization key i.e xebia-validator.pem in our case
4.) You need to create knife.rb which you can view from Chef Web UI
5.) You need to create a chef-repo: chef generate app chef-repo along with git initilization
6.) You need fetch the ssl certificate: knife ssl_fetch
7.) Verify Workstation configured properly: knife node list
