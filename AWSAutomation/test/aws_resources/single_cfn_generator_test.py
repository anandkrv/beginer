import sys
sys.path.append("/vagrant/src/cfn_generator")
from single_cfn_generator import SingleCfnGenerator

singleCfnGenerator = SingleCfnGenerator("10.0.0.0/16")

print singleCfnGenerator.getCfnConfiguration()
