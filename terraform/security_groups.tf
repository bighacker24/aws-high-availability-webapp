resource "aws_security_group" "alb" {
  name        = "ha-web-alb-sg"
  description = "Security group for the public Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "ha-web-alb-sg"
  }
}

resource "aws_security_group" "app" {
  name        = "ha-web-app-sg"
  description = "Security group for private EC2 application servers"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "ha-web-app-sg"
  }
}

resource "aws_security_group" "db" {
  name        = "ha-web-db-sg"
  description = "Security group for private PostgreSQL RDS"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "ha-web-db-sg"
  }
}
