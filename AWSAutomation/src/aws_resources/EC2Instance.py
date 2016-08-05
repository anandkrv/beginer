from string import Template

class Ec2Instance:

    def __init__(self, name, imageId, instanceType, keyName, subnet, securitygroup, public=True, privateIp=None):
        self.name = name
        self.imageId = imageId
        self.instanceType = instanceType
        self.keyName  = keyName
        self.subnet = subnet
        self.privateIp = privateIp
        self.securitygroup = securitygroup
	self.public = public

    def getName(self):
        return self.name

    def getEc2InstanceTemplate(self):
      if self.public:
        Ec2InstanceTemplate = Template('"Ec2Instance": {\
    "Type": "AWS::EC2::Instance",\
    "Properties": {\
      "ImageId": {\
        "Ref": "$imageId"\
      },\
      "InstanceType": {\
        "Ref": "$instanceType"\
      },\
      "KeyName": {\
        "Ref": "$keyName"\
      },\
      "SecurityGroupIds": {\
        "Ref": "$securitygroup"\
      },\
      "SubnetId": {\
        "Ref": "$subnet"\
      },\
      "PrivateIpAddress": {\
        "Ref": "$privateIp"\
      },\
      "Tags": [{\
        "Key": "Name",\
        "Value": {\
          "Ref": "$name"\
        }\
      }]\
    }\
  },\
  "AllocateElasticIP": {\
    "Condition": "AllocateIp",\
    "DependsOn": ["EC2Instance"],\
    "Type": "AWS::EC2::EIP",\
    "Properties": {\
      "InstanceId": {\
        "Ref": "EC2Instance"\
      },\
      "Domain": "vpc"\
    }\
  }')
        return Ec2InstanceTemplate.substitute(name=self.name, imageId=self.imageId, instanceType=self.instanceType, keyName=self.keyName, subnet=self.subnet.getName(), securityGroupIds=self.securitygroup.getName(), privateIp=self.privateIp)
      else:
        Ec2InstanceTemplate = Template('"Ec2Instance": {\
   "Type": "AWS::EC2::Instance",\
  "Properties": {\
    "ImageId": {\
      "Ref": "$imageId"\
    },\
    "InstanceType": {\
      "Ref": "$instanceType"\
    },\
    "KeyName": {\
      "Ref": "$keyName"\
    },\
    "SecurityGroupIds": {\
      "Ref": "$securitygroup"\
    },\
    "SubnetId": {\
      "Ref": "$subnet"\
    },\
    "PrivateIpAddress": {\
      "Ref": "$privateIp"\
    },\
    "Tags": [{\
      "Key": "Name",\
      "Value": {\
        "Ref": "$name"\
      }\
    }]\
  }\
}')
        return Ec2InstanceTemplate.substitute(name=self.name, imageId=self.imageId, instanceType=self.instanceType, keyName=self.keyName, subnet=self.subnet.getName(), securitygroup=self.securitygroup.getName(), privateIp=self.privateIp)
  



