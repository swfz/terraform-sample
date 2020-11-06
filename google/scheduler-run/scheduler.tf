resource "google_cloud_scheduler_job" "job" {
  name             = "test-job"
  description      = "test http job"
  schedule         = "*/8 * * * *"
  time_zone        = "Asia/Tokyo"
  attempt_deadline = "320s"
  project          = local.project
  region           = local.region

  retry_config {
    retry_count          = 1
    max_backoff_duration = "3600s"
    max_doublings        = 5
    max_retry_duration   = "0s"
    min_backoff_duration = "5s"
  }

  http_target {
    http_method = "POST"
    uri         = "${local.url}/"
    body        = "RunFromScheduler"
    headers     = {}

    oidc_token {
      audience              = local.url
      service_account_email = google_service_account.run_invoker.email
    }
  }
}