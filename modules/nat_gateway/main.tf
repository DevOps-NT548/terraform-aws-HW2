resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "public" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "Public NAT"
  }
}
