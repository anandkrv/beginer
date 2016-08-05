import sys
sys.path.append("/vagrant/src/aws_resources")
from vpc import VPC
from igw import IGW

vpc = VPC("10.0.1.0/16")
vpc.setId("vpcDummy")

igw = IGW(vpc)

igwTemplate = igw.getIGWTemplate()
print igwTemplate
