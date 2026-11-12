resource "aws_route_table" "private_app" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ha-private-app-rt"
  }
}

resource "aws_route_table_association" "private_app" {
  for_each = { for name, s in local.subnets : name => s if s.tier == "app" }

  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.private_app.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.private_app.id]

  tags = {
    Name = "ha-s3-endpoint"
  }
}
