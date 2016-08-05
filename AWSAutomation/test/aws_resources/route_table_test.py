import sys
sys.path.append("/vagrant/src/aws_resources")
from route_table import RouteTable

routeTable = RouteTable("public")


routeTableTemplate = routeTable.getRouteTableTemplate()
print routeTableTemplate
