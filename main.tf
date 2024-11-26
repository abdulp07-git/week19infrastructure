provider "aws" {
  region = "ap-south-1"
}

module "networking" {
  source = "./networking"
}

module "SecurityGroup" {
  source = "./securityGroup"
  vpc_id = module.networking.vpc-id
  PubSubnetids = module.networking.PubSubnetids
  PvtSubnetids = module.networking.PvtSubnetids
  PubSubnetcidr = module.networking.PubSubnetcidr
  PvtSubnetcidr = module.networking.PvtSubnetcidr

}

module "Database" {
  source = "./database"
  vpc_id = module.networking.vpc-id
  DatabaseSg = module.SecurityGroup.DatabaseSgid
  PvtSubnetids = module.networking.PvtSubnetids
}

module "staticFiles" {
  source = "./staticFiles"
}

module "distribution" {
  source = "./distribution"
  BucketName = module.staticFiles.BucketName
  BucketDomainName = module.staticFiles.BucketDomainName
  OriginId = module.staticFiles.OriginId
  AclID = module.staticFiles.AclID
}


module "loadbalancer" {
  source = "./loadbalancer"
  vpc-id = module.networking.vpc-id
  PubSubnetids = module.networking.PubSubnetids
  PvtSubnetids = module.networking.PvtSubnetids
  ServerSgid = module.SecurityGroup.ServerSgid
}

module "scale" {
  source = "./scale"
  vpc-id = module.networking.vpc-id
  PubSubnetids = module.networking.PubSubnetids
  lbid = module.loadbalancer.lbid
  tgarn = module.loadbalancer.tgarn

}

module "route53" {
  source = "./route53"
  lburl = module.loadbalancer.lburl
  lbzoneid = module.loadbalancer.lbzoneid
}




resource "aws_s3_bucket" "w19tfbackend" {
    bucket = "w19tfbackend"
}

resource "aws_s3_bucket_versioning" "w19tfbackendversion" {
  bucket = aws_s3_bucket.w19tfbackend.id
  versioning_configuration {
    status = "Enabled"
  }
}



resource "aws_dynamodb_table" "w19tf_state_lock_table" {
  name = "w19tf_state_lock_table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "w19tf_state_lock_table"
  }
}

terraform {
  backend "s3" {
    bucket = "w19tfbackend"
    key = "terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    dynamodb_table = "w19tf_state_lock_table"

  }
}


