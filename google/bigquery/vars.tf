variable "region" {}
variable "project" {}

locals {
  region  = var.region
  project = var.project
  schema = {
    report = [
      {
        name        = "dt"
        type        = "DATE"
        mode        = "REQUIRED"
        description = "date"
      },
      {
        name        = "metadata_id"
        type        = "INTEGER"
        mode        = "REQUIRED"
        description = "uk1"
      },
      {
        name        = "classification"
        type        = "STRING"
        mode        = "REQUIRED"
        description = "uk2"
      },
      {
        name        = "value1"
        type        = "INTEGER"
        mode        = "NULLABLE"
        description = "value1"
      }
    ],
    metadata = [
      {
        name        = "metadata_id"
        type        = "INTEGER"
        mode        = "REQUIRED"
        description = "uk1"
      },
      {
        name        = "classification"
        type        = "STRING"
        mode        = "REQUIRED"
        description = "uk2"
      },
      {
        name        = "name"
        type        = "STRING"
        mode        = "REQUIRED"
        description = "name"
      },
      {
        name        = "status"
        type        = "STRING"
        mode        = "REQUIRED"
        description = "enable or disable"
      },
      {
        name        = "column1"
        type        = "STRING"
        mode        = "NULLABLE"
        description = "c1"
      },
    ]
  }
}