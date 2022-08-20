########### VPC ###########
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

####### Two public subnets ########
resource "aws_subnet" "pub_sub_1" { 
    vpc_id = aws_vpc.vpc.id 
    cidr_block = "10.0.1.0/24"           
    map_public_ip_on_launch = true       
    availability_zone = "eu-east-2"
}
 
resource "aws_subnet" "pub_sub_2" { 
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.2.0/24"	         
    map_public_ip_on_launch = true       
    availability_zone = "eu-east-2"
}

####### Two private subnets #######                   
resource "aws_subnet" "priv_sub_1" { 		
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = false
    availability_zone = "eu-east-2"
}

resource "aws_subnet" "priv_sub_2" { 
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = false
    availability_zone = "eu-east-2"
}

######### Main routing table ########
resource "aws_route_table" "mainRT" {   
    vpc_id = aws_vpc.vpc.id
    route {
    cidr_block = "0.0.0.0/0"               
    gateway_id = aws_internet_gateway.ig.id
     }
}

######### Main routing table association ############
resource "aws_route_table_association" "mainRTass1" {    
    subnet_id = aws_subnet.pub_sub_1.id
    route_table_id = aws_route_table.mainRT.id
}

resource "aws_route_table_association" "mainRTass2" {    
    subnet_id = aws_subnet.pub_sub_2.id
    route_table_id = aws_route_table.mainRT.id
}

############ Internet Gateway #############
resource "aws_internet_gateway" "ig" {  
    vpc_id = aws_vpc.vpc.id
}