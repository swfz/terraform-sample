locals {
  endpoints = toset(["storage","secret_manager"])
}

resource "google_cloud_scheduler_job" "job" {
  name             = "test-job-${each.value}"
  description      = "test http job"
  schedule         = "0 0 1 * *"
  time_zone        = "Asia/Tokyo"
  attempt_deadline = "320s"
  project          = local.project
  region           = local.region

  for_each = local.endpoints

  retry_config {
    retry_count          = 1
    max_backoff_duration = "3600s"
    max_doublings        = 5
    max_retry_duration   = "0s"
    min_backoff_duration = "5s"
  }

  http_target {
    http_method = "POST"
    uri         = "${local.url}/${each.value}"
    body        = base64encode("RunFromScheduler")
    headers     = {}

    oidc_token {
      audience              = local.url
      service_account_email = google_service_account.run_invoker.email
    }
  }
}