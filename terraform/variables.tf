variable "credentials" {
  description = "My Credentials"
  default     = "/home/shaunak/reddit-war-opinion/mage/my-credentials.json"
}

variable "project" {
  description = "Project"
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
  default     = "rwo-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}