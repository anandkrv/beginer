from string import Template

class Subnet:

    def __init__(self, name, cidrBlock, az):
        self.name = name
        self.cidrBlock = cidrBlock
        self.az = az

    def getName(self):
        return self.name

    def getSubnetTemplate(self):
        subnetTemplate = Template('"$name": {\
      "Type": "AWS::EC2::Subnet",\
      "DependsOn": ["VPC", "AttachGateway"],\
      "Properties": {\
        "VpcId": {"Ref": "VPC"},\
        "CidrBlock": {"$cidrBlock},\
        "AvailabilityZone": {"$az"},\
        "Tags": [{\
            "Key": "Name",\
            "Value": "$name"\
          }\
        ]\
      }\
    }')
        return subnetTemplate.substitute(name=self.name, cidrBlock=self.cidrBlock, az=self.az)
