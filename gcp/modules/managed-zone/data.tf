data "google_dns_managed_zone" "primary" {
  name = google_dns_managed_zone.primary.name
}

/*
data "google_compute_address" "istio_ingressgateway_lb" {
  name = "${google_compute_address.istio_ingressgateway_lb.name}"
}
*/
