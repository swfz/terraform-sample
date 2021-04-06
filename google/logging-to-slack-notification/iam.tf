locals {
  sa_roles = [
    "roles/pubsub.publisher",
    "roles/logging.logWriter",
  ]
}

resource "google_project_iam_member" "service_account_role" {
  count  = length(local.sa_roles)
  role   = element(local.sa_roles, count.index)
  member = google_logging_project_sink.sample_sink.writer_identity
}
