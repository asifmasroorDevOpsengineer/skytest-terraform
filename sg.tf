#### Server SG 
resource "aws_security_group" "web-server" {
  name_prefix = "Web-Server-SG"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform = true
    Name      = "Web Server SG"
  }
}


resource "aws_security_group" "alb" {
  name_prefix = "alb-test"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Terraform = true
    Name      = "ALB SG"
  }
}


resource "aws_security_group_rule" "Alb" {
  type                     = "ingress"
  security_group_id        = aws_security_group.web-server.id
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb.id
}

