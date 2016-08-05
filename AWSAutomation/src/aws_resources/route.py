from string import Template

class Route:

    def __init__(self, name, routeTable, destCidr, public=True):
        self.name = name
        self.routeTable = routeTable
        self.destCidr = destCidr
        self.public = public

    def getName(self):
        return self.name

    def setNatInstance(self, natInstance):
        self.natInstance = natInstance

    def getRouteTemplate(self):
        if self.public:
            routeTemplate = Template('"$name": {\
      "Type": "AWS::EC2::Route",\
      "DependsOn": "$routeTableRef",\
      "Properties": {\
        "RouteTableId": {"Ref": "$routeTableRef"},\
        "DestinationCidrBlock": "$destCidr",\
        "GatewayId": {"Ref": "InternetGateway"}\
      }\
    }')
            return routeTemplate.substitute(name=self.name, routeTableRef=self.routeTable.getName(), destCidr=self.destCidr)
        else:
            routeTemplate = Template('"$name": {\
      "Type": "AWS::EC2::Route",\
      "DependsOn": ["$natInstanceRef", "$routeTableRef", "AttachGateway", "VPC"],\
      "Properties": {\
        "RouteTableId": {"Ref": "$routeTableRef"},\
        "DestinationCidrBlock": "$destCidr",\
        "InstanceId": {"Ref": "$natInstanceRef"}\
      }\
    }')
            return routeTemplate.substitute(name=self.name, natInstanceRef=self.natInstance.getName(), routeTableRef=self.routeTable.getName(), destCidr=self.destCidr)
