output "cloudfronurl" {
  value = aws_cloudfront_distribution.StaticDistribution.domain_name
}
