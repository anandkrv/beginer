variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "ap-southeast-1"
}

# NAT AMI (x64)
variable "aws_amis" {
  default = {
    ap-southeast-1 = "ami-1a9dac48"
  }
}

# APP AMI 
variable "aws_appamis" {
  default = {
    ap-southeast-1 = "ami-50025a02"
  }
}

# puppet master AMI
variable "aws_puppetami" {
  default = {
    ap-southeast-1 = "ami-25c00c46"
  }
}