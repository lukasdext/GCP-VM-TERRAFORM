terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("chave.json")

  project = "teste-vm-354219"
  region  = "us-central1"
  zone    = "us-central1-c"
}


//crinado rede

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}


// criando vm

resource "google_compute_instance" "VM" {
  name         = "primeiravm"
  machine_type = "e2-micro"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = "echo oi > /test.txt"

}