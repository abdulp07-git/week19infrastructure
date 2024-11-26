output "ServerSgid" {
  value = aws_security_group.ServerSg.id
}
output "DatabaseSgid" {
  value = aws_security_group.DatabaseSg.id
}
