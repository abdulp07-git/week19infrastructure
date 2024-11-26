locals {
  prefix = "w19-"
}
resource "aws_security_group" "ServerSg" {
  vpc_id = var.vpc_id
  
  dynamic "ingress" {
    for_each = var.ports
    content {
      description = ingress.value["description"]
      from_port = ingress.value["port"]
      to_port = ingress.value["port"]
      protocol = "tcp"
      cidr_blocks = [ "0.0.0.0/0" ]
    }

    
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${local.prefix}ServerSg"
  }
}

resource "aws_security_group" "DatabaseSg" {
  vpc_id = var.vpc_id
  
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = var.PubSubnetcidr
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "${local.prefix}DatabaseSg"
  }
}
