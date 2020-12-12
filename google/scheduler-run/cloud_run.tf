data google_container_registry_image app {
  name = "sample-run"
}

resource google_cloud_run_service default {
  name     = "cloudrun-srv"
  location = local.region

  template {
    metadata {
      labels = {
        environment = "dev"
      }
    }
    spec {
      containers {
        image = data.google_container_registry_image.app.image_url
        env {
          name  = "BUCKET"
          value = google_storage_bucket.bucket.name
        }
        env {
          name  = "SHORT_SHA"
          value = local.short_sha
        }
        env {
          name  = "PROJECT_ID"
          value = local.project
        }
      }
      service_account_name = google_service_account.run_invoker.email
      timeout_seconds      = 900
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

locals {
  url = google_cloud_run_service.default.status[0].url
}

output url {
  value = local.url
}