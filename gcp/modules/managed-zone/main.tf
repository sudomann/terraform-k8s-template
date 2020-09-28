resource "google_dns_managed_zone" "primary" {
  name        = var.zone_name
  dns_name    = var.dns_name
  description = var.dns_zone_description
  visibility  = "public"

  dnssec_config {
    state = "on"
  }
}


resource "google_dns_record_set" "subdomain_wildcard" {
  managed_zone = google_dns_managed_zone.primary.name
  name         = "*.${google_dns_managed_zone.primary.dns_name}"
  type         = "CNAME"
  ttl          = 300 # seconds; 5 minutes
  rrdatas      = [google_dns_record_set.api.name]
}


resource "google_compute_address" "istio_ingressgateway_lb" {
  name         = "${var.reserved_address_name}"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  description  = "${var.reserved_address_description}"
}


resource "google_dns_record_set" "api" {
  managed_zone = google_dns_managed_zone.primary.name
  name         = "api.${google_dns_managed_zone.primary.dns_name}"
  type         = "A"
  ttl          = 300 # seconds; 5 minutes

  # google_compute_address data source below
  # is null and causes `apply` to fail if:
  #   address resources has not yet been created
  # solution:
  #   comment it out usage of the data scourse
  #   create/apply google_compute_address resource first
  #    uncomment data source usage and `apply`
  # rrdatas = ["${data.google_compute_address.istio_ingressgateway_lb.address}"]

  # for now use hardcoded ip; whatever ip istio's ingressgateway load balancer
  # gets assigned by GCP
  # The value given below is a dummy example
  rrdatas = ["101.101.101.101"]
}

