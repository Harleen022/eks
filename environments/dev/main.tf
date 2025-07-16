provider "aws" {
  region = "us-east-1"  # N. Virginia region
}

module "terraform_state_bucket" {
  source = "../../modules/s3"
  bucket_name = "harleen-s3-5432"
}

# VPC Configuration
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "main-vpc"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "ubuntu_server" {
  name        = "ubuntu-server-sg"
  description = "Security group for Ubuntu server"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ubuntu-server-sg"
  }
}

# EC2 Instance
module "ubuntu_server" {
  source = "../../modules/ec2"

  instance_name      = "ubuntu-server"
  instance_type      = "t2.micro"
  subnet_id          = aws_subnet.public.id
  security_group_ids = [aws_security_group.ubuntu_server.id]
  key_name           = "wordpress-key"  # Replace with your key pair name
  
  environment        = "dev"
  root_volume_size   = 20
} 