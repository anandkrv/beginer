from string import Template

class IgwVpcAssoc:

    def __init__(self, vpc = None, igw = None):
        self.vpc = vpc
        self.igw = igw

    def getIgwVpcAssociationTemplate(self):
        igwVpcAssociationTemplate = '"AttachGateway": {"Type": "AWS::EC2::VPCGatewayAttachment",\
      "DependsOn": ["VPC", "InternetGateway"],\
      "Properties": {\
        "VpcId": {"Ref": "VPC"},\
        "InternetGatewayId": {"Ref": "InternetGateway"}\
      }\
    }'
        return igwVpcAssociationTemplate
