resource "google_container_cluster" "primary" {
    name = "primary"
    location = "us-west4"
    remove_default_node_pool = true
    initial_node_count = 1
    network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.private-subnet.self_link
    logging_service = "logging.googleapis.com/kubernetes"
    monitoring_service = "monitoring.googleapis.com/kubernetes"
    networking_mode = "VPC_NATIVE"
    

    node_locations = [
        "us-west4-b"
    ]

    addons_config{
        http_load_balancing {
            disabled    = true
        }
        horizontal_pod_autoscaling {
            disabled    = false
        }
    }

    release_channel {
        channel =   "REGULAR"
    }

    workload_identity_config {
        workload_pool   =   "devsecops-431009.svc.id.goog"
    }

    ip_allocation_policy {
        cluster_secondary_range_name    = "k8s-pod-range"
        services_secondary_range_name   = "k8s-service-range"
    }

    private_cluster_config {
        enable_private_nodes    = true
        enable_private_endpoint = false
        master_ipv4_cidr_block  = "172.16.0.0/28"
    }
  
}
