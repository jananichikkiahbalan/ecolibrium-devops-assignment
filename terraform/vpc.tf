resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet-1"

    "kubernetes.io/role/elb" = "1"

    "kubernetes.io/cluster/ecolibrium-eks" = "shared"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet-2"

    "kubernetes.io/role/elb" = "1"

    "kubernetes.io/cluster/ecolibrium-eks" = "shared"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet-1"

    "kubernetes.io/role/internal-elb" = "1"

    "kubernetes.io/cluster/ecolibrium-eks" = "shared"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet-2"

    "kubernetes.io/role/internal-elb" = "1"

    "kubernetes.io/cluster/ecolibrium-eks" = "shared"
  }
}