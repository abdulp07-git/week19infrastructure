resource "aws_db_subnet_group" "DatabaseSubnetgroup" {
  name = "dbsubnetgroup"
  subnet_ids =  var.PvtSubnetids 
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = var.Secret
}

locals {
    db_password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]

}

resource "aws_db_instance" "Database" {
  instance_class = var.Dbinstance
  allocated_storage = 20
  engine = var.Engine
  username = "postgres"
  password = local.db_password
  vpc_security_group_ids = [ var.DatabaseSg ]
  availability_zone = "ap-south-1c"
  db_subnet_group_name = aws_db_subnet_group.DatabaseSubnetgroup.name
  
  lifecycle {
    ignore_changes = [
      storage_encrypted,
      skip_final_snapshot,
      max_allocated_storage,
      enabled_cloudwatch_logs_exports,
      deletion_protection,
      tags,
    ]
  }


}
