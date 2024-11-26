variable "Dbinstance" {
  type = string
  default = "db.t4g.micro"
}

variable "Engine" {
  type = string
  default = "Postgres"
}

variable "Secret" {
  type = string
  default = "arn:aws:secretsmanager:ap-south-1:021891584638:secret:dev/django/postgres-iQUhkM"
}

variable "vpc_id" {
  type = string
}

variable "DatabaseSg" {
  type = string
}

variable "PvtSubnetids" {
  type = list(string)
}
