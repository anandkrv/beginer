from string import Template

class SecurityGroup:

    def __init__(self, name, vpc):
        self.name = name
        self.vpc = vpc

    def getName(self):
        return self.name

    def getSecurityGroupTemplate(self):
        SecurityGroupTemplate = Template('"$name" : {\
   "Type" : "AWS::EC2::SecurityGroup",\
   "Properties" : {\
      "GroupDescription" : "Allow ssh client to access host",\
      "VpcId" : {"Ref" : "$vpc"},\
      "SecurityGroupIngress" : [{\
            "IpProtocol" : "tcp",\
            "FromPort" : "22",\
            "ToPort" : "22",\
            "CidrIp" : "0.0.0.0/0"\
         }],\
      "SecurityGroupIngress" : [{\
            "IpProtocol" : "tcp",\
            "FromPort" : "80",\
            "ToPort" : "80",\
            "CidrIp" : "0.0.0.0/0"\
         }],\
      "Tags" : [{"Key" : "Name", "Value" : { "Ref" : "$name"}}\
   ]\
      }\
   }')
        return SecurityGroupTemplate.substitute(name=self.name, vpc=self.vpc)
