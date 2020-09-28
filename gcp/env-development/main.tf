provider "google" {
  version     = "= 3.14.0"
  project     = "mygcpproject-dev"
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
  machine_type = "custom-4-4096"
  k8s_version  = "${var.desired_k8s_version}"
}

module "gke_node_pool_2" {
  source       = "../modules/preemptible-node-pool/"
  pool_name    = "preemptible-pool-2"
  location     = "us-east1"
  cluster_name = "${module.gke_cluster.name}"
  machine_type = "custom-2-4096"
  k8s_version  = "${var.desired_k8s_version}"
}


module "gke_node_pool_3" {
  source       = "../modules/preemptible-node-pool/"
  pool_name    = "preemptible-pool-3"
  location     = "us-east1"
  cluster_name = "${module.gke_cluster.name}"
  machine_type = "custom-2-4096"
  k8s_version  = "${var.desired_k8s_version}"
}


module "build_trigger_api_service" {
  # Build docker image which will run in Kubernetes to serve API
  source      = "../modules/build-tag-trigger/"
  repo_name   = "github_sudomann_myproduct-backend"
  build_dir   = "path/to/folder/containing/Dockerfile/"
  image_name  = "api_service"
  description = "Build api_service"
}


module "managed_zone" {
  source   = "../modules/managed-zone/"
  dns_name = "dev.${var.fqdn}."
}

module "bucket" {
  source  = "../modules/bucket/"
  is_prod = "false"
}

output "name_servers" {
  value = module.managed_zone.name_servers
}

