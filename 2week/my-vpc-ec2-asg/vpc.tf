provider "aws" {
  region  = "ap-northeast-2"
}

resource "aws_vpc" "woojinvpc" {
  cidr_block       = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "t101-study"
  }
}

resource "aws_subnet" "woojinsubnet1" {
  vpc_id     = aws_vpc.woojinvpc.id
  cidr_block = "10.10.1.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "t101-subnet1"
  }
}

resource "aws_subnet" "woojinsubnet2" {
  vpc_id     = aws_vpc.woojinvpc.id
  cidr_block = "10.10.2.0/24"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "t101-subnet2"
  }
}


resource "aws_internet_gateway" "woojinigw" {
  vpc_id = aws_vpc.woojinvpc.id

  tags = {
    Name = "t101-igw"
  }
}

resource "aws_route_table" "woojinrt" {
  vpc_id = aws_vpc.woojinvpc.id

  tags = {
    Name = "t101-rt"
  }
}

resource "aws_route_table_association" "woojinrtassociation1" {
  subnet_id      = aws_subnet.woojinsubnet1.id
  route_table_id = aws_route_table.woojinrt.id
}

resource "aws_route_table_association" "woojinrtassociation2" {
  subnet_id      = aws_subnet.woojinsubnet2.id
  route_table_id = aws_route_table.woojinrt.id
}

resource "aws_route" "woojindefaultroute" {
  route_table_id         = aws_route_table.woojinrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.woojinigw.id
}

