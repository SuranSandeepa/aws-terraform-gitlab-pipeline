#1 VPC, 1 subnet and 1 security group

resource "aws_vpc" "main_vpc"{
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true 
    enable_dns_support = true 

    tags = {
        Name = "susanvpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true #Automatically assigns a public IP address to any instance launched in this subnet.
    availability_zone = "us-east-1a" #a data center in AWS

    tags = {
        Name = "pb_sn1"
    }
}

resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main_vpc.id
  name = "susan_sg"
  description = "Public Security Group"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



