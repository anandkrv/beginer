import sys
sys.path.append("/vagrant/src/aws_resources")
from route_table_association import RouteTableAssociation
from route_table import RouteTable
from subnet import Subnet

subnet = Subnet("subnet1", "10.0.1.0/24", "us-east-1a")
routeTable = RouteTable("public")
routeTableAssociation = RouteTableAssociation("public", subnet, routeTable)


routeTableAssociationTemplate = routeTableAssociation.getRouteTableAssociationTemplate()
print routeTableAssociationTemplate
