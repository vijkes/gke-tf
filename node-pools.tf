resource "google_service_account" "kubernetes" {
    account_id = "kubernetes"
  
}

resource "google_container_node_pool" "general" {
    name = "general"
    cluster = google_container_cluster.primary.id
    node_count = 1
    management {
      auto_repair = true
      auto_upgrade = true
    }

    node_config {
      preemptible = false
      machine_type = "e2-small"

      labels = {
        role    = "general"
      }
      

      service_account = google_service_account.kubernetes.email
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
}

resource "google_container_node_pool" "spot" {
    name = "spot"
    cluster = google_container_cluster.primary.id


    management {
      auto_repair = true
      auto_upgrade = true
    }
  
    autoscaling {
      min_node_count = 0
      max_node_count = 5
    }

    node_config {
      preemptible = true
      machine_type = "e2-small"

      labels = {
        team = "devops"
      }

      taint {
        key = "instance_type"
        value = "spot"
        effect = "NO_SCHEDULE"
      }
      service_account = google_service_account.kubernetes.email
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ] 
    }
}