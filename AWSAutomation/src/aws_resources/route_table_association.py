from string import Template

class RouteTableAssociation:

    def __init__(self, name, subnet, routeTable):
        self.name = name
        self.subnet = subnet
        self.routeTable = routeTable


    def getRouteTableAssociationTemplate(self):
        routeTableAssociationTemplate = Template('"$name": {\
      "Type": "AWS::EC2::SubnetRouteTableAssociation",\
      "DependsOn": ["$subnet", "$routeTable"],\
      "Properties": {\
        "SubnetId": {"Ref": "$subnet"},\
        "RouteTableId": {"Ref": "$routeTable"}\
      }\
    }')
        return routeTableAssociationTemplate.substitute(name=self.name, subnet=self.subnet.getName(), routeTable=self.routeTable.getName())
