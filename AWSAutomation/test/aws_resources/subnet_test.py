import sys
sys.path.append("/vagrant/src/aws_resources")
from subnet import Subnet

subnet = Subnet("subnet1", "10.0.1.0/24", "us-east-1a")


subnetTemplate = subnet.getSubnetTemplate()
print subnetTemplate
