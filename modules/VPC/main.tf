#----------------VPC module----------------

data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.cidr

  tags = merge({
    Name = "vpc-${var.name}"
  }, var.tags)
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "igw-${var.name}"
  }, var.tags)
}


#---------------Public Subnets----------------

resource "aws_subnet" "public_subnet" {
  count                   = 1
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = merge({
    Name = "public-subnet-${var.name}"
  }, var.tags)
}

resource "aws_route_table" "public_subnet_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "Route-public-subnet"
  }
}

resource "aws_route" "public_route" {
  count                  = 1
  route_table_id         = aws_route_table.public_subnet_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = 1
  route_table_id = aws_route_table.public_subnet_rt.id
  subnet_id      = aws_subnet.public_subnet[0].id
}

