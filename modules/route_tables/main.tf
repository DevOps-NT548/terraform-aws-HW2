# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id  # Attach to the Internet Gateway
  }

  tags = {
    "Name" = "public-route-table"
  }
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat_gateway_id  # Attach to the NAT Gateway
  }

  tags = {
    "Name" = "private-route-table"
  }
}

# Associate Public Route Table with Public Subnets
resource "aws_route_table_association" "public_association" {
  for_each       = { for k, v in var.public_subnet_ids : k => v }
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

# Associate Private Route Table with Private Subnets
resource "aws_route_table_association" "private_association" {
  for_each       = { for k, v in var.private_subnet_ids : k => v }
  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
