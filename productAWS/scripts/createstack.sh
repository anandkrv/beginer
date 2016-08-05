#!/usr/bin/env bash
set -o nounset
set -o errexit

#AMI=${1:-}

#if [[ -z ${AMI} ]];then
#  echo "no ami supplied, bailing" >&2
#  exit 1
#fi
cd /var/lib/jenkins/scripts/cloudFormation/OpstreeCfn/vpc
aws  cloudformation create-stack \
--stack-name ${STACK_NAME} \
--template-body file://VPCIGW.json \
--parameters \
ParameterKey=VPCName,ParameterValue=${VPC_NAME} \
ParameterKey=IGWName,ParameterValue=prod-gw \
ParameterKey=validCIDR,ParameterValue=${cidr} \
#ParameterKey=KeyName,ParameterValue=lybrate_staging \
#ParameterKey=Subnets,ParameterValue=subnet-9734f4e0 \
#ParameterKey=SecurityGroups,ParameterValue=sg-88eb57ed \
#ParameterKey=Loadbalancer,ParameterValue=vpc-staging \
#ParameterKey=LYBEnvironment,ParameterValue=stage \
