resource "aws_s3_bucket" "staticFiles" {
  bucket = "w19staticfiles"

  tags = {
    Name = "staticFiles"
  }
}

resource "aws_s3_bucket_ownership_controls" "staticFiles" {
  bucket = aws_s3_bucket.staticFiles.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "staticFiles" {
  bucket = aws_s3_bucket.staticFiles.id

  block_public_acls = false
  block_public_policy = false 
  ignore_public_acls = false 
  restrict_public_buckets = false 
}

resource "aws_s3_bucket_acl" "staticFiles" {
  depends_on = [ 
    aws_s3_bucket_ownership_controls.staticFiles,
    aws_s3_bucket_public_access_block.staticFiles,
   ]  
  bucket = aws_s3_bucket.staticFiles.id
  acl = "public-read"
}


resource "aws_s3_bucket_cors_configuration" "staticFiles" {
    bucket = aws_s3_bucket.staticFiles.id

    cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"] # Adjust for stricter security
    max_age_seconds = 3600
    }

}


resource "aws_s3_bucket_policy" "staticFiles" {
  bucket = aws_s3_bucket.staticFiles.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "StaticFilePolicy"
    Statement = [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.staticFiles.arn}/*"
        }
    ]
  }
   
  )
}
