locals {
  prefix = "w19-"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "${local.prefix}vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.prefix}igw"
  }
}

resource "aws_subnet" "PubSubnets" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.PubSubnet)
  cidr_block = var.PubSubnet[count.index]["cidr"]
  availability_zone = var.PubSubnet[count.index]["region"]
  tags = {
    Name = "${local.prefix}${var.PubSubnet[count.index]["tag"]}"
  }
}

resource "aws_subnet" "PvtSubnets" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.PvtSubnet)
  cidr_block = var.PvtSubnet[count.index]["cidr"]
  availability_zone = var.PvtSubnet[count.index]["region"]
  tags = {
    Name = "${local.prefix}${var.PvtSubnet[count.index]["tag"]}"
  }
}


resource "aws_route_table" "PubRoutetable" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${local.prefix}PubRoutetable"
  }

}


resource "aws_route_table" "PvtRoutetable" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "${local.prefix}PvtRoutetable"
  }

}

resource "aws_route_table_association" "PubSubnetAssoc" {
  route_table_id = aws_route_table.PubRoutetable.id
  count = length(var.PubSubnet)
  subnet_id = aws_subnet.PubSubnets[count.index].id
}

resource "aws_route_table_association" "PvtSubnetAssoc" {
  route_table_id = aws_route_table.PvtRoutetable.id
  count = length(var.PvtSubnet)
  subnet_id = aws_subnet.PvtSubnets[count.index].id
}
