from string import Template

class RouteTable:

    def __init__(self, name):
        self.name = name


    def getName(self):
        return self.name

    def getRouteTableTemplate(self):
        routeTableTemplate = Template('"$name": {\
      "Type": "AWS::EC2::RouteTable",\
      "DependsOn": ["VPC", "AttachGateway"],\
        "Properties": {\
        "VpcId": {"Ref": "VPC"},\
        "Tags": [\
          {\
            "Key": "Name",\
            "Value": "$name"\
          }\
        ]\
      }\
    }')
        return routeTableTemplate.substitute(name=self.name)
