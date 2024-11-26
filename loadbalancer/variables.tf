  variable "vpc-id" {
    type = string
  }
  
  variable "PubSubnetids" {
    type = list(string)
  }

  variable "PvtSubnetids" {
    type = list(string)
  }

variable "ServerSgid" {
    type = string
}


  
