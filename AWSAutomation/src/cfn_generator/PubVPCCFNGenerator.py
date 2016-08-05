import sys
sys.path.append("/vagrant/src/aws_resources")
from vpc import VPC
from igw import IGW
from igw_vpc_association import IgwVpcAssoc
from route_table_association import RouteTableAssociation
from route_table import RouteTable
from subnet import Subnet
from route import Route
from security_group import SecurityGroup
from EC2Instance import Ec2Instance

class PubVPCCfnGenerator:

    def __init__(self, cidrBlock, az):
        self.cidrBlock = cidrBlock
        self.az = az
        self.__initializeResources()
        self.__generateCfnConfiguration()

    def __initializeResources(self):
        self.vpc = VPC(self.cidrBlock)
        self.igw = IGW()
        self.igwVpcAssoc = IgwVpcAssoc()
        self.pubRouteTable = RouteTable("public")
        self.pubRoute = Route("publicRoute", self.pubRouteTable, self.cidrBlock)
        self.subnet = Subnet("subnet1", self.cidrBlock, self.az)
        self.routeTableAssociation = RouteTableAssociation("public", self.subnet, self.pubRouteTable)
        self.securitygroup = SecurityGroup("test", self.vpc)
	self.instance = Ec2Instance("test-name", "ami-12345", "t2.micro", "key.pem", self.subnet, self.securitygroup, False, "192.168.007.007")

    def __generateCfnConfiguration(self):
        self.cfnConfiguration = self.vpc.getVPCTeplate()

        self.cfnConfiguration += ","
        self.cfnConfiguration += self.igw.getIGWTemplate()
        self.cfnConfiguration += ","
        self.cfnConfiguration += self.igwVpcAssoc.getIgwVpcAssociationTemplate()
        self.cfnConfiguration += ","
        self.cfnConfiguration += self.pubRouteTable.getRouteTableTemplate()
        self.cfnConfiguration += ","
        self.cfnConfiguration += self.routeTableAssociation.getRouteTableAssociationTemplate()
        self.cfnConfiguration += ","
        self.cfnConfiguration += self.pubRoute.getRouteTemplate()
        self.cfnConfiguration += ","
        self.cfnConfiguration += self.securitygroup.getSecurityGroupTemplate()
	self.cfnConfiguration += ","
        self.cfnConfiguration += self.instance.getEc2InstanceTemplate()

    def getCfnConfiguration(self):
        return self.cfnConfiguration

