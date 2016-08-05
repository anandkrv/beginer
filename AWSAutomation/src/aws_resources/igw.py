from string import Template

class IGW:

    def __init__(self, vpc = None):
        self.vpc = vpc

    def getIGWIndependentTemplate(self):
        igwTempate = Template('"InternetGateway": {"Type": "AWS::EC2::InternetGateway","Ref": "$vpcId"}')
        return igwTempate.substitute(vpcId=self.vpc.getId())

    def getIGWTemplate(self):
        return '"InternetGateway": {"Type": "AWS::EC2::InternetGateway","DependsOn": "VPC"}'
