 #Load Balancer
 module "alb" {
  source = "terraform-aws-modules/alb/aws"
  depends_on = [
    module.vpc,
    aws_instance.web-server
  ]

  name = "Alb-My-test"

  load_balancer_type = "application"
  internal           = false

  vpc_id = module.vpc.vpc_id
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1],
    module.vpc.public_subnets[2]
  ]

  security_groups = [aws_security_group.alb.id]
  target_groups = [
    {
      name_prefix      = "TG1-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        tg1 = {
          target_id = aws_instance.web-server[0].id
        }
      }
    },
    {
      name_prefix      = "TG2-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        tg1 = {
          target_id = aws_instance.web-server[1].id
        }
      }
    }
  ]
}


resource "aws_lb_listener" "test" {
  
  depends_on = [
    module.alb,
  ]
  load_balancer_arn = module.alb.lb_arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = module.alb.target_group_arns[0]
        weight = var.weight_tg1
      }
      target_group {
        arn    = module.alb.target_group_arns[1]
        weight = var.weight_tg2
      }
    }
  }
}