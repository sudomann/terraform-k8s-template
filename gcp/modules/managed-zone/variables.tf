variable "zone_name" {
  default = "myproduct-dns"
}

variable "dns_name" {
}

variable "dns_zone_description" {
  default = "MyProduct DNS zone"
}

variable "reserved_address_name" {
  default = "myproduct-istio-ingress"
}

variable "reserved_address_description" {
  default = <<EOF
    IP for Istio's default igressgateway
    load balancer
  
EOF

}

