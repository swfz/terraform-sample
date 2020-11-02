resource "google_storage_bucket" "private-bucket" {
  name          = "test-bucket-1111111"
  location      = "asia-northeast1"
  storage_class = "REGIONAL"

  labels = {
    app = "test-app"
    env = "test"
  }
}
