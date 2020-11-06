data "google_compute_default_service_account" "default" {
}

resource "google_cloud_scheduler_job" "job" {
  name             = "test-job"
  description      = "test http job"
  schedule         = "*/8 * * * *"
  time_zone        = "Asia/Tokyo"
  attempt_deadline = "320s"

  retry_config {
    retry_count = 1
  }

  http_target {
    http_method = "POST"
    uri         = local.url
    body = "RunFromScheduler"

    oidc_token {
      // service_account_email = data.google_compute_default_service_account.default.email
      service_account_email = google_service_account.run_invoker.email
    }
  }
}