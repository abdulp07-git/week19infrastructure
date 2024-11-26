variable "vpc_id" {
  type = string
}

variable "PubSubnetids" {
  type = list(string)
}

variable "PvtSubnetids" {
  type = list(string)
}

variable "PubSubnetcidr" {
  type = list(string)
}

variable "PvtSubnetcidr" {
  type = list(string)
}

variable "ports" {
  type = list(map(string))
  default = [ 
    {
    "port" = "22"
    "description" = "ssh"
  },
  
  {
    "port" = "80"
    "description" = "http"
  },

  {
    "port" = "443"
    "description" = "https"
  },

  {
    "port" = "8000"
    "description" = "application"
  },
  
   ]
  
}
