data "google_container_registry_image" "app" {
  name = "sample-run"
}
data "google_compute_default_service_account" "default" {
}
data "google_project" "project" {
}
resource "google_cloud_run_service" "default" {
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
          name = "SHORT_SHA"
          value = local.short_sha
        }
        env {
          name = "PROJECT_ID"
          value = data.google_project.project.project_id
        }
      }
      service_account_name = google_service_account.run_invoker.email
      timeout_seconds = 900
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "invoker" {
  binding {
    role = "roles/run.invoker"
    members = [
      "serviceAccount:${google_service_account.run_invoker.email}"
    ]
  }
}

resource "google_service_account" "run_invoker" {
  project      = local.project
  account_id   = "cloud-run-invoker-sa"
  display_name = "Cloud Run Invoker Service Account"
}

resource "google_cloud_run_service_iam_policy" "run_policy" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name
  policy_data = data.google_iam_policy.invoker.policy_data
}

resource "google_storage_bucket_iam_binding" "cloud_run_custom_role_cloud_run_service_account_binding" {
  bucket = google_storage_bucket.bucket.name
  role = "roles/storage.admin"

  members = [
    format("serviceAccount:%s", google_service_account.run_invoker.email)
  ]
}

locals {
  url = google_cloud_run_service.default.status[0].url
}

output "url" {
  value = local.url
}