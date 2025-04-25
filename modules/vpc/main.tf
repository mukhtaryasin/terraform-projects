resource "aws_vpc" "this" {
    cidr_block = var.cidr_block # The CIDR block for the VPC    
    tags = {
        Name = var.vpc_name
    }  
}
resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)# Number of subnets to create
    vpc_id = aws_vpc.this.id # The ID of the VPC to create the subnet in
    cidr_block = var.public_subnet_cidrs[count.index] # The CIDR block for the subnet
    map_public_ip_on_launch = true # Assign public IP addresses to instances launched in this subnet
    availability_zone = var.azs[count.index] # The availability zone for the subnet
    tags = {
        Name = "${var.vpc_name}-public-${count.index + 1}"
        
    }
  
}
resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs) # Number of subnets to create
    vpc_id = aws_vpc.this.id # The ID of the VPC to create the subnet in
    cidr_block = var.private_subnet_cidrs[count.index] # The CIDR block for the subnet
    map_public_ip_on_launch = false # Do not assign public IPs to instances in this subnet
    availability_zone = var.azs[count.index] # The availability zone for the subnet
    tags = {
        Name = "${var.vpc_name}-private-${count.index + 1}"
            }
  
}
resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id # The ID of the VPC to create the internet gateway in
    tags = {
        Name = "${var.vpc_name}-igw"
    }
}
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id # The ID of the VPC to create the route table in
    
    route {
        cidr_block = "0.0.0.0/0" # The CIDR block for the route
        gateway_id = aws_internet_gateway.this.id # The ID of the internet gateway to use for the route
    }
    tags = {
        Name = "${var.vpc_name}-public"
    }
    
}
resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public) # Number of route table associations to create
    subnet_id = aws_subnet.public[count.index].id # The ID of the subnet to associate with the route table
    route_table_id = aws_route_table.public.id # The ID of the route table to associate with the subnet

}

resource "aws_security_group" "this" {
    vpc_id = aws_vpc.this.id # The ID of the VPC to create the security group in
    name = "${var.vpc_name}-sg" # The name of the security group
    description = "Security group for ${var.vpc_name}" # The description of the security group
    ingress {
        from_port = 22 # The starting port for the ingress rule port 22 is for SSH access
        to_port = 22 # The ending port for the ingress rule
        protocol = "tcp" # The protocol for the ingress rule
        cidr_blocks = var.allowed_ips
    }
    ingress {
        from_port = 80 # The starting port for the ingress rule port 80 is for HTTP access
        to_port = 80 # The ending port for the ingress rule
        protocol = "tcp" # The protocol for the ingress rule
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0 # The starting port for the egress rule port 0 is for all ports
        to_port = 0 # The ending port for the egress rule
        protocol = "-1" # The protocol for the egress rule
        cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
    }
    
    tags = {
        Name = "${var.vpc_name}-sg"
    }
}