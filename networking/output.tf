output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "PubSubnetids" {
  value = [for subnet in aws_subnet.PubSubnets: subnet.id]
}
output "PvtSubnetids" {
  value = [for subnet in aws_subnet.PvtSubnets: subnet.id]
}

output "PubSubnetcidr" {
  value = [for subnet in aws_subnet.PubSubnets: subnet.cidr_block]
}

output "PvtSubnetcidr" {
  value = [for subnet in aws_subnet.PvtSubnets: subnet.cidr_block]
}
