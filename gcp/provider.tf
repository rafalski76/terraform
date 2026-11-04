terraform {
  required_version = ">= 1.10"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.0"
    }
  }
}

provider "google" {
  credentials = file("${path.module}/prod-svc-creds.json")
  project     = "szkola-chmury-proj"
  region      = "europe-central2"
  zone        = "europe-central2-a"
}

