data "google_container_registry_image" "app" {
  name = "pubsub"
}

resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv"
  location = local.region

  template {
    spec {
      containers {
        image = data.google_container_registry_image.app.image_url
        env {
          name  = "BUCKET"
          value = "swfz-cloudrun-storage"
        }
        env {
          name = "SHORT_SHA"
          value = local.short_sha
        }
      }
      timeout_seconds = 900
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "run_act_as" {
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
  policy_data = data.google_iam_policy.run_act_as.policy_data
}

locals {
  url = google_cloud_run_service.default.status[0].url
}

output "url" {
  value = local.url
}