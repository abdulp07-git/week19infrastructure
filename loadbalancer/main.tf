locals {
  prefix = "w19-"
}

resource "aws_lb_target_group" "TargetGroup" {
  name = "${local.prefix}TargetGroup"
  port = 8000
  protocol = "HTTP"
  vpc_id = var.vpc-id

  tags = {
    Name = "${local.prefix}TargetGroup"
  }

}

resource "aws_lb" "LB" {
  name = "${local.prefix}lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.ServerSgid]
  subnets = var.PubSubnetids

  tags = {
    Name = "${local.prefix}lb"
    Environment = "Production"
  }
}


resource "aws_lb_listener" "LbListener" {
  load_balancer_arn = aws_lb.LB.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.TargetGroup.arn
  }
}
