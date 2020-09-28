resource "google_container_cluster" "primary" {
  name        = var.name
  location    = var.location
  description = <<EOF
    GKE Cluster for MyProduct's backend (e.g. Iroha, DRF, .NET, ExpressJS, Spring, etc.) 
    and maybe frontend (e.g. Django, Spring, etc.) infrastructure
EOF


  network = var.network

  # TODO: maybe make use of `google_container_engine_versions` data source?
  min_master_version = var.min_master_version

  /* TODO: need to study and implement this
   ip_aliases (with PVC native) become default from June 17th 2019
  ip_allocation_policy = [
    { use_ip_aliases = true },
    { create_subnetwork = false },
    { subnetwork_name = "myproduct-gke-network" },
    { cluster_ipv4_cidr_block = "" },
    { cluster_secondary_range_name = "" },
    { node_ipv4_cidr_block = "" },
    { services_ipv4_cidr_block = "" },
    { services_secondary_range_name = "" }
  ]
*/
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    #  basic authentication and client certificate issuance disabled 
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  enable_legacy_abac = false

  network_policy {
    provider = "CALICO"
    enabled  = true
  }

  addons_config {
    network_policy_config {
      disabled = false
    }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00" # [HH-MM] GMT
    }
  }
}

output "name" {
  value = google_container_cluster.primary.name
}

