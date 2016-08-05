#!/bin/bash
function cidrRangeCal() {
  noDigitCidr=32
  ipRange=$1
  ipRangeInBinary=$(echo "obase=2;$ipRange" | bc)
  DigitCount=$(echo "${#ipRangeInBinary}")
  cidrRange=`expr $noDigitCidr - $DigitCount`
  echo $cidrRange
}

function tags() {
   resourcesId=$1
   resourcesName=$2
   region=$3
   aws --region ${region} ec2 create-tags --resources $resourcesId --tags Key=Name,Value=$resourcesName

}
