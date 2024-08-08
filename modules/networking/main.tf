resource "aws_vpc" "vpc_id" {
  cidr_block = var.vpc_cidr
  tags = {
    name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnets_ids" {
  count = length(var.cidr_public_subnet)
  vpc_id = aws_vpc.vpc_id.id
  cidr_block = element(var.cidr_public_subnet,count.index)
  availability_zone = element(var.us_availibility_zone,count.index)
  tags = {
    name = "public subnets"
  }
}

resource "aws_subnet" "private_subnets_ids" {
  count = length(var.cidr_private_subnet)
  vpc_id = aws_vpc.vpc_id.id
  cidr_block = element(var.cidr_private_subnet,count.index)
  availability_zone = element(var.us_availibility_zone,count.index)
  tags = {
    name = "private subnets"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc_id.id
  tags = {
    name = "igw"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_id.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    name = "public rt"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count = length(aws_subnet.public_subnets_ids)
  subnet_id = aws_subnet.public_subnets_ids[count.index].id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc_id.id
  tags = {
    name = "private route table"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count = length(aws_subnet.private_subnets_ids)
  subnet_id = aws_subnet.private_subnets_ids[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}