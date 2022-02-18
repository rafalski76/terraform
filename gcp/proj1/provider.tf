terraform {
  required_providers {
    google = {
      version = "~> 4.0.0"
    }
  }
}

provider "google" {
  credentials = file("${path.module}/prod-svc-creds.json")
  project     = "szkola-chmury-proj"
  region      = "europe-central2"
  zone        = "europe-central2-a"
}

