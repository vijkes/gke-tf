provider "google" {
    project = "devops-cicd"
    region = "us-east4"
  
}

terraform {
  backend "gcs" {
    bucket = "gke-cicd-july"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "~> 4.0"
    }
  }
}