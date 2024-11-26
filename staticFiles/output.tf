output "BucketName" {
  value = "w19staticfiles"
}

output "BucketDomainName" {
  value = aws_s3_bucket.staticFiles.bucket_regional_domain_name
}

output "OriginId" {
  value = aws_s3_bucket.staticFiles.id
}

output "AclID" {
  value = aws_s3_bucket_acl.staticFiles.id
}
