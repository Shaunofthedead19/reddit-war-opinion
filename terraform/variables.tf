variable "credentials" {
  description = "My Credentials"
  default     = "/home/shaunak/reddit-war-opinion/de-project-terraform.json"
}

variable "project" {
  description = "Project"
  default     = "de-project-418719"
}

variable "location" {
  description = "Project Location"
  default     = "australia-southeast2"
}

variable "region" {
  description = "Project Region"
  default     = "australia-southeast2"
}

variable "bq_dataset_name" {
  description = "Reddit War Opinion Dataset"
  default     = "rwo_dataset"
}

variable "bq_stage_dataset_name" {
  description = "Reddit War Opinion Dataset"
  default     = "stg_rwo_dataset"
}

variable "bq_prod_dataset_name" {
  description = "Reddit War Opinion Dataset"
  default     = "prod_rwo_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "de-project-418719-rwo-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}