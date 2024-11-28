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

variable "cert" {
  type = string
  default = "arn:aws:acm:ap-south-1:021891584638:certificate/70f3779f-0093-42d7-8d29-ed1ee79d14c0"
}


  
