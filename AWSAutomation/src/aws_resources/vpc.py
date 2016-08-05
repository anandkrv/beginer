from string import Template

class VPC:

    def __init__(self, cidrBlock):
        self.cidrBlock = cidrBlock

    def getVPCTeplate(self):
        vpcTempate = Template('"VPC": {"Type": "AWS::EC2::VPC","Properties": {"CidrBlock": {"Ref": "$cidrBlock"}}')
        return vpcTempate.substitute(cidrBlock=self.cidrBlock)

    def setId(self, id):
        self.id = id

    def getId(self):
        return self.id
