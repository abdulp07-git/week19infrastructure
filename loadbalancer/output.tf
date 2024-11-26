output "lbid" {
  value = aws_lb.LB.id
}

output "tgarn" {
  value = aws_lb_target_group.TargetGroup.arn
}

output "lburl" {
  value = aws_lb.LB.dns_name
}

output "lbzoneid" {
  value = aws_lb.LB.zone_id
}
