import sys
sys.path.append("/vagrant/src/aws_resources")
from vpc import VPC

vpc = VPC("10.0.1.0/16")
vpcTemplate = vpc.getVPCTeplate()

print vpcTemplate
