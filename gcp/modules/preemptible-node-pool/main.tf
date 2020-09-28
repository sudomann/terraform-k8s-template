resource "google_container_node_pool" "preemptible_nodes" {
  name       = var.pool_name
  cluster    = var.cluster_name
  location   = var.location
  node_count = var.node_count

  version = var.k8s_version

  node_config {
    preemptible  = true
    machine_type = var.machine_type # custom-4-4096" // 4 vCPUs, 1024 (MB) * 4 (GB)
    disk_size_gb = 10

    metadata = {
      disable-legacy-endpoints = "true"
    }

    # "https://www.googleapis.com/auth/devstorage.read_only"
    # is needed for pulling app containers from Cloud Storage
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = false # should not be fighting with node k8s version
  }
}

