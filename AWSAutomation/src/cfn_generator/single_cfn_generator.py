import sys
sys.path.append("/vagrant/src/aws_resources")
from vpc import VPC
from igw import IGW
from igw_vpc_association import IgwVpcAssoc


class SingleCfnGenerator:

    def __init__(self, cidrBlock):
        self.cidrBlock = cidrBlock
        self.__initializeResources()
        self.__generateCfnConfiguration()

    def __initializeResources(self):
        self.vpc = VPC(self.cidrBlock)
        self.igw = IGW()
        self.igwVpcAssoc = IgwVpcAssoc()

    def __generateCfnConfiguration(self):
        self.cfnConfiguration = self.vpc.getVPCTeplate()

        self.cfnConfiguration += ","
        self.cfnConfiguration += self.igw.getIGWTemplate()
        self.cfnConfiguration += ","
        self.cfnConfiguration += self.igwVpcAssoc.getIgwVpcAssociationTemplate()

    def getCfnConfiguration(self):
        return self.cfnConfiguration
