provider "google" {
    credentials = file("/home/hpuser/.config/gcloud/application_default_credentials.json")
    project = "devops-cicd-430308"
    region = "us-west4"
  
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
