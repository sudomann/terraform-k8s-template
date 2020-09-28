provider "google" {
  version     = "= 3.14.0"
  project     = "mygcpproject-prod"
  region      = "us-east1"
  credentials = var.credentials
}

module "vpc" {
  source = "../modules/vpc/"
}


module "gke_cluster" {
  source             = "../modules/regional-cluster/"
  name               = "myproduct"
  location           = "us-east1"
  network            = "${module.vpc.network_name}"
  min_master_version = "${var.desired_k8s_version}"
}

module "gke_node_pool_1" {
  source       = "../modules/preemptible-node-pool/"
  pool_name    = "preemptible-pool"
  location     = "us-east1"
  cluster_name = "${module.gke_cluster.name}"
  machine_type = "custom-2-4096"
  k8s_version  = "${var.desired_k8s_version}"
}


module "managed_zone" {
  source   = "../modules/managed-zone/"
  dns_name = "${var.fqdn}."
}

module "bucket" {
  source  = "../modules/bucket/"
  is_prod = "true"
}

# ==========================
# DNS RECORDS FOR PROD ONLY
# ==========================

resource "google_dns_record_set" "dev_subdomain_delegated" {
  name         = "dev.${module.managed_zone.dns_name}"
  managed_zone = module.managed_zone.zone_name
  type         = "NS"
  ttl          = 300 # seconds; 5 minutes
  rrdatas      = var.dev_env_name_servers
}

# ==========================
