import sys
sys.path.append("/vagrant/src/aws_resources")
from vpc import VPC
from igw_vpc_association import IgwVpcAssoc



igwVpcAssoc = IgwVpcAssoc()

igwVpcAssocTemplate = igwVpcAssoc.getIgwVpcAssociationTemplate()
print igwVpcAssocTemplate
