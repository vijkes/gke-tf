resource "google_compute_router" "router" {
  name = "gke-router"
  region = "us-east4"
  network = google_compute_network.vpc_network.id
}