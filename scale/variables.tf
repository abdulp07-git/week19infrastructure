variable "template" {
  type = string
  default = "lt-0ccb5a50f9f46c136"
}

variable "lbid" {
  type = string
}

variable "tgarn" {
  type = string
}

variable "vpc-id" {
  type = string
}

variable "PubSubnetids" {
  type = list(string)
}
