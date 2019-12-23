terraform {
  required_version = "~> 0.12"
}

provider "google" {
  credentials = var.gcp_key
  project     = var.project
  region      = var.region
}

resource "google_compute_instance" "vm_instance" {
  name = "terraform-instance-${count.index}"
  machine_type = var.machine_type
  count = var.hello_tf_instance_count
  zone = "asia-northeast1-a"
  labels = {
    owner = "kabu",
    ttl = "100"
  }
  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config {
    }
  }
}
