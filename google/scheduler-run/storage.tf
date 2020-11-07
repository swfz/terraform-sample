
resource "google_storage_bucket" "bucket" {
  name          = "swfz-cloudrun-with-gcs"
  force_destroy = true
  labels = {
    environment = "development"
    managed_by  = "terraform"
  }
  versioning {
    enabled = true
  }
}

output "bucket_url" {
  value       = google_storage_bucket.bucket.url
  description = "base URL of the Bucket"
}