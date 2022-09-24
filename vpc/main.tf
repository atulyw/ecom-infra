resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  tags = merge({
    #Name = "vpc-${var.namespace}-${var.env}"
    Name = format("vpc-%s-%s", var.namespace, var.env, )
  }, var.tags)
}

resource "aws_subnet" "private" {
  count             = length(var.private_cidr_blocks)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_cidr_blocks[count.index]
  availability_zone = element(var.availability_zone, count.index)
  tags = merge({
    Name = format("private-%s-%s-%s", var.namespace, element(var.availability_zone, count.index), var.env)
  }, var.tags)
}

resource "aws_subnet" "public" {
  count                   = length(var.public_cidr_blocks)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_cidr_blocks[count.index]
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = merge({
    Name = format("public-%s-%s-%s", var.namespace, element(var.availability_zone, count.index), var.env)
  }, var.tags)
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route" "nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

resource "aws_route" "igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}