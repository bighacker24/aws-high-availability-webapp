resource "aws_eip" "nat" {
  count  = var.enable_nat ? 1 : 0
  domain = "vpc"

  tags = {
    Name = "ha-nat-eip"
  }
}

resource "aws_nat_gateway" "main" {
  count         = var.enable_nat ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.this["public_a"].id

  tags = {
    Name = "ha-nat-a"
  }

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route" "app_internet" {
  count                  = var.enable_nat ? 1 : 0
  route_table_id         = aws_route_table.private_app.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[0].id
}
