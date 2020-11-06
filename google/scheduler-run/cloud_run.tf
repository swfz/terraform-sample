
resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv"
  location = local.region

  template {
    spec {
      containers {
        image = "gcr.io/${local.project}/pubsub"
        env {
          name = "BUCKET"
          value = "swfz-cloudrun-storage"
        }
        env {
          name = "KEY3"
          value = "VALUE3"
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
  project = local.project
  account_id   = "cloud-run-invoker-sa"
  display_name = "Cloud Run Invoker Service Account"
}

resource "google_cloud_run_service_iam_policy" "run_policy" {
  location = google_cloud_run_service.default.location
  project = google_cloud_run_service.default.project
  service = google_cloud_run_service.default.name
  policy_data = data.google_iam_policy.run_act_as.policy_data
}

// resource "google_cloud_run_service_iam_binding" "binding" {
//   location = google_cloud_run_service.default.location
//   project = google_cloud_run_service.default.project
//   service = google_cloud_run_service.default.name
//   role = "roles/iam.serviceaccounts.actAs"
//   members = [
//     "servi${local.project_number}-compute@developer.gserviceaccount.com",
//   ]
// }


// resource "google_cloud_run_service_iam_member" "run_invoker" {
//   project  = google_cloud_run_service.default.project
//   location = google_cloud_run_service.default.location
//   service  = google_cloud_run_service.default.name
//   role     = "roles/run.invoker"
//   member   = "serviceAccount:${google_service_account.run_invoker.email}"
// }

locals {
  url = google_cloud_run_service.default.status[0].url
}

output "url" {
  value = local.url
}