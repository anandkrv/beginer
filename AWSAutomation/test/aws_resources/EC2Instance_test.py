import sys
sys.path.append("/vagrant/src/aws_resources")
from EC2Instance import Ec2Instance

instance = Ec2Instance("test-name", "ami-12345", "t2.micro", "key.pem", self.subnet, "security-123456", False, "192.168.007.007")
instanceTemplate = instance.getEc2InstanceTemplate()
print instanceTemplate
