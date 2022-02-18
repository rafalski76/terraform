resource "google_compute_instance" "this" {
  provider     = google
  name         = "tf-instance"
  machine_type = "e2-micro"
  zone         = "europe-central2-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Left blank to assign public IP
    }
  }

  metadata = {
    ssh-keys = "${var.username}:${file("~/.ssh/gcp_vm.pub")}"
  }

  metadata_startup_script = "sudo apt-get update; echo 'Hello World!' >> /home/${var.username}/startup"
}

// Enable Cloud Run service
resource "google_project_service" "gcp_services" {
  project = "szkola-chmury-proj"
  service = "run.googleapis.com"
}
