output "name_servers" {
  value = data.google_dns_managed_zone.primary.name_servers
}

output "dns_name" {
  value = data.google_dns_managed_zone.primary.dns_name
}

output "zone_name" {
  value = google_dns_managed_zone.primary.name
}

