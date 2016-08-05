import sys
sys.path.append("/vagrant/src/cfn_generator")
from PubVPCCFNGenerator import PubVPCCfnGenerator

pubVPCCfnGenerator = PubVPCCfnGenerator("10.0.0.0/16","us-east-1a")


print pubVPCCfnGenerator.getCfnConfiguration()
