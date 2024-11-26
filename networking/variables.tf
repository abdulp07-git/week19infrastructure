
variable "vpc-cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "PubSubnet" {
  type = list(map(string))
  default = [ 
  {
    "tag" = "PubSubnet1"
    "cidr" = "10.0.1.0/24"
    "region" = "ap-south-1a"
  },
  
  {
    "tag" = "PubSubnet2"
    "cidr" = "10.0.2.0/24"
    "region" = "ap-south-1b"
  }
  
   ]
}

variable "PvtSubnet" {
  type = list(map(string))
  default = [ 
  {
    "tag" = "PvtSubnet1"
    "cidr" = "10.0.3.0/24"
    "region" = "ap-south-1c"
  },

    {
    "tag" = "PvtSubnet2"
    "cidr" = "10.0.4.0/24"
    "region" = "ap-south-1a"
  }
]
}
