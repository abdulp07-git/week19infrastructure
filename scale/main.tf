locals {
  prefix = "w19-"
}

resource "aws_autoscaling_group" "AutoScale" {
  name = "${local.prefix}autoscale"
  min_size = 0
  max_size = 0
  desired_capacity = 0
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




# Create a CloudWatch Alarm to monitor CPU utilization
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${local.prefix}high-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 10
  statistic           = "Average"
  threshold           = 50
  alarm_description   = "Alarm when CPU exceeds 50%"
  actions_enabled     = true

  # The Auto Scaling group will react to this alarm
  alarm_actions = [aws_autoscaling_policy.scale_out.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.AutoScale.name
  }
}

# Scaling policy to add instances when the alarm is triggered
resource "aws_autoscaling_policy" "scale_out" {
  name                   = "${local.prefix}scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.AutoScale.name
}

# Scaling policy to remove instances if needed
resource "aws_autoscaling_policy" "scale_in" {
  name                   = "${local.prefix}scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.AutoScale.name
}
