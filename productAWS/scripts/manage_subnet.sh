#!/bin/bash

function createRouteTable(){
	vpcId=$1
	region=$2
	name=$3
	rtTableId=`aws --region ${region} ec2 create-route-table --vpc-id ${vpcId} | jq --raw-output .RouteTable.RouteTableId`
	tags ${rtTableId} ${name} ${region} > /dev/null
	echo ${rtTableId}
}

function createSubnet(){
	vpcId=$1
	region=$2
	subnetcidr=$3
	az=$4
	name=$5
	subnetID=`aws --region ${region} ec2 create-subnet --availability-zone ${az} --vpc-id ${vpcId} --cidr-block ${subnetcidr} | jq --raw-output .Subnet.SubnetId`
	tags ${subnetID} ${name} ${region} > /dev/null
	echo ${subnetID}
}

function associateSubnetWithRouteTable(){
	vpcId=$1
	rttableId=$2
	subnetId=$3
}

function addIGWToRouteTable(){
	vpcId=$1
	rttableId=$2
}

function addNATInstanceToRouteTable(){

}

fucnction createNATSg(){
	vpcID=$1
	sgName=$2
}

function createNATInstance(){

}

function calculateCIDRRange(){
	number_ips=$1
	
} 

function createPublicSubnet() {
	cidr_block=$1
	subnet_name=$2
	vpc_id=$3
	availability_zone=$4
	region=$5
	name=$6
	sbntid=`createSubnet ${vpc_id} ${region} ${cidr} ${availability_zone} ${name}`
	rtID=`createRouteTable ${vpc_id} ${region}`
	associateSubnetWithRouteTable
	addIGWToRouteTable
}

function createPrivateSubnet(){
	cidr_block=$1
        subnet_name=$2
        vpc_id=$3
        availability_zone=$4
	region=$5
	name=$6
        sbntid=`createSubnet ${vpc_id} ${region} ${cidr} ${availability_zone} ${name}`
	rtId=`createRouteTable ${vpc_id} ${region}`
	associateSubnetWithRouteTable
	createNATInstance
	addNATInstanceToRouteTable
}
