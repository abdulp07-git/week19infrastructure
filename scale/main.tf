locals {
  prefix = "w19-"
}

resource "aws_autoscaling_group" "AutoScale" {
  name = "${local.prefix}autoscale"
  min_size = 1
  max_size = 3
  desired_capacity = 2
  vpc_zone_identifier = var.PubSubnetids
  launch_template {
    id = var.template
    version = "$Latest"
  }

  target_group_arns = [ var.tgarn ]

  tag {
    key = "Name"
    value = "${local.prefix}instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
