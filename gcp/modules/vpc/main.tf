resource "google_compute_network" "myproduct" {
  name                    = "myproduct"
  description             = "VPC network for MyProduct infrastructure"
  auto_create_subnetworks = "true"     # default is true
  routing_mode            = "REGIONAL" # default is REGIONAL
}

output "network_name" {
  value = google_compute_network.myproduct.name
}

/* TODO: Maybe?? Switch to manual subnet creation, or perhaps drops this configuration entirely 
 * if firewall can be entirely replicated with a network overlay (or something) in k8s
*/

# The following rules are taken from GCP's default network, automatic settings

/*
resource "google_compute_firewall" "allow_icmp" {
  name        = "allow-icmp"
  network     = "${google_compute_network.myproduct.name}"
  description = "Allows ICMP connections from any source to any instance on the network."
  direction   = "INGRESS"
  disabled    = false
  priority    = 65534

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}
*/

resource "google_compute_firewall" "allow_internal" {
  name        = "allow-internal"
  network     = google_compute_network.myproduct.name
  description = "Allows connections from any source in the network IP range to any instance on the network using all protocols."
  direction   = "INGRESS"
  disabled    = false
  priority    = 65534

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.128.0.0/9"]
}

/*
resource "google_compute_firewall" "allow_rdp" {
  name        = "allow-rdp"
  network     = "${google_compute_network.myproduct.name}"
  description = "Allows RDP connections from any source to any instance on the network using port 3389."
  direction   = "INGRESS"
  disabled    = false
  priority    = 65534

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}
*/

resource "google_compute_firewall" "allow_ssh" {
  name        = "allow-ssh"
  network     = google_compute_network.myproduct.name
  description = "Allows TCP connections from any source to any instance on the network using port 22."
  direction   = "INGRESS"
  disabled    = false
  priority    = 65534

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

/*  The following are implied and imutable rules 
    from https://cloud.google.com/vpc/docs/firewalls#default_firewall_rules
resource "google_compute_firewall" "iroha" {
    name = "deny-all-ingress"
    network = "${google_compute_network.iroha}"
    description = "Denies all incoming traffic."
}

resource "google_compute_firewall" "iroha" {
    name = "allow-all-egress"
    network = "${google_compute_network.iroha}"
    description = "Allows all outbound traffic."
}
*/
