provider "google" {
  project = "data-eng-wagon"
  region  = "europe-west2"
}

// Create a Google Cloud Storage bucket for the data lake
resource "google_storage_bucket" "data_lake" {
  name     = "my-data-lake-bucket"
  location = "EUROPE-WEST2"
}

// Create a BigQuery dataset
resource "google_bigquery_dataset" "example" {
  dataset_id                  = "my_dataset"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = "EUROPE-WEST2"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}

// Create a BigQuery table
resource "google_bigquery_table" "example" {
  dataset_id = google_bigquery_dataset.example.dataset_id
  table_id   = "my_table"

  schema = <<EOF
[
  {
    "name": "name",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "age",
    "type": "INTEGER",
    "mode": "REQUIRED"
  }
]
EOF
}

// Create a VM instance with an SSH key
resource "google_compute_instance" "vm_instance" {
  name         = "vm-ubuntu"
  machine_type = "e2-medium"
  zone         = "europe-west2-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  metadata_startup_script =  "${file("startup.sh")}"
}

