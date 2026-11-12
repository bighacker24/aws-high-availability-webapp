locals {
  subnets = {
    public_a = { cidr = "10.0.1.0/24", az = "us-east-2a", tier = "public" }
    public_b = { cidr = "10.0.2.0/24", az = "us-east-2b", tier = "public" }
    app_a    = { cidr = "10.0.11.0/24", az = "us-east-2a", tier = "app" }
    app_b    = { cidr = "10.0.12.0/24", az = "us-east-2b", tier = "app" }
    db_a     = { cidr = "10.0.21.0/24", az = "us-east-2a", tier = "db" }
    db_b     = { cidr = "10.0.22.0/24", az = "us-east-2b", tier = "db" }
  }
}

resource "aws_subnet" "this" {
  for_each = local.subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "ha-${each.key}"
    Tier = each.value.tier
  }
}
