
resource "aws_vpc" "vpc" {

  cidr_block = "10.53.0.0/16"

  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc"
  }
}

resource "aws_internet_gateway" "vpc-internet-gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "vpc-internet-gateway"
  }
}

resource "aws_default_route_table" "vpc-internet-route" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-internet-gateway.id
  }
}