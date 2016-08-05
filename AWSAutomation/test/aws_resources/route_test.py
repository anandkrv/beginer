import sys
sys.path.append("/vagrant/src/aws_resources")
from route import Route
from route_table import RouteTable


pubRouteTable = RouteTable("public")
pubRoute = Route("publicRoute", pubRouteTable, "10.0.1.0/24")

pubRouteTemplate = pubRoute.getRouteTemplate()
print pubRouteTemplate

pvtRouteTable = RouteTable("private")
pvtRoute = Route("pvtRoute", pubRouteTable, "10.0.1.0/24", False)
#Need to integrate with EC2 instance for that EC2 instance
pvtRoute.setNatInstance(None)
