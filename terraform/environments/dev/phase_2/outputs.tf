output "hosted_zone_id" {
  value       = module.dns.hosted_zone_id
  description = "Route53 hosted zone ID"
}

output "nameservers" {
  value       = module.dns.nameservers
  description = "Route53 nameservers to configure with your domain registrar"
}