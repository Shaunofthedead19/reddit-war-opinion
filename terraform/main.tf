terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.23.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

resource "google_storage_bucket" "rwo-bucket" {
  name                     = var.gcs_bucket_name
  location                 = var.location
  force_destroy            = true
  public_access_prevention = "enforced"

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "source_dataset" {
  dataset_id                 = var.bq_dataset_name
  location                   = var.location
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset" "stage_dataset" {
  dataset_id                 = var.bq_stage_dataset_name
  location                   = var.location
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset" "prod_dataset" {
  dataset_id                 = var.bq_prod_dataset_name
  location                   = var.location
  delete_contents_on_destroy = true
}