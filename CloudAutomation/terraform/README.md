steps for terraform
1. download the terraform
wget https://releases.hashicorp.com/terraform/0.6.16/terraform_0.6.16_linux_amd64.zip

2. unzip it in /opt
unzip terraform_0.6.16_linux_amd64.zip

3. update your /etc/environment by appending this
:/opt/terraform

like
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/terraform"

4. check the version to confirm that terraform it install properly
vagrant@dev:~$ terraform --version
Terraform v0.6.16

5. create a file for aws creds and put these line with keys
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""

and source this file with source command

6. clone the repo
https://github.com/OpsTree/CloudAutomation.git

7. create a ssh key
ssh-keygen

8. go to the terraform dir run this dir
$ terraform plan

      A. Enter the key name
          var.key_name
                  Desired name of AWS key pair

                    Enter a value: <Key name>
                   it will create a aws key with this name

      B. var.public_key_path
  Path to the SSH public key to be used for authentication.
  Ensure this keypair is added to your local SSH agent so provisioners can
  connect.
 
  Example: ~/.ssh/terraform.pub

  Enter a value: <SSH PUB KEY>

9. if every this goes well then run this command
 $ terraform apply

10. to destory
$ terraform destory

### If the all instance up then puth the config file into your ~/.ssh directory and change the key and NAT instance ups with your instance elasticIP and keyname

# To create puppet agnet run following commands

```
curl https://raw.githubusercontent.com/OpsTree/CloudAutomation/master/terraform/puppetagent.sh | bash -s -- <ENVIRONMENT> <COMPONENT> <Availability ZONE>
```

For Example:

Look into config file for server entry like

dev.app.az.a.xebia.training.com

Where  
ENVIRONMENT       = dev  
COMPONENT         = app  
Availability ZONE = a  

Use these values to fill in the options of "curl" command as per accordingly. 

After successful completion of "curl" command type following command to sync puppet agent to puppet master. 
$ puppet agent -t --debug

# To Create puppet master run the following command on the (dev.puppet.az.b.xebia.tainging.com)
curl https://raw.githubusercontent.com/OpsTree/CloudAutomation/master/terraform/puppetmaster.sh | bash -s -- dev puppet b


