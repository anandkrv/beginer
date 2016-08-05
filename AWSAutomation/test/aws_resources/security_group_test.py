import sys
sys.path.append("/vagrant/src/aws_resources")
from security_group import SecurityGroup

securitygroup = SecurityGroup("test", "main-vpc")
securityGroupTemplate = securitygroup.getSecurityGroupTemplate()
print securityGroupTemplate

