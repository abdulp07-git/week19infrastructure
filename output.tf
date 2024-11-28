output "LoadBalancerUrl" {
  value = module.loadbalancer.lburl
  description = "Load balancer URL"
}

output "DatabaseEndpoint" {
  value = module.Database.endpoint
  description = "Database endpoint"
}

output "Nameservers" {
  value = module.route53.awsnameservers
}

output "cloudfronturl" {
  value = module.distribution.cloudfronurl
}
