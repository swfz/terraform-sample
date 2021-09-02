resource "google_service_account" "workflow_invoker" {
  project      = data.google_client_config.current.project
  account_id   = "workflow-invoker-sa"
  display_name = "Workflow Invoker Service Account"
}


locals {
  invoker_sa_roles = [
    "roles/workflows.invoker",
    "roles/iam.serviceAccountUser",
    "roles/logging.logWriter",
  ]
  logging_sa_roles = [
    "roles/logging.logWriter",
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
  ]
}

resource "google_project_iam_member" "invoker_service_account_role" {
  count  = length(local.logging_sa_roles)
  role   = element(local.logging_sa_roles, count.index)
  member = "serviceAccount:${google_service_account.workflow_invoker.email}"
}

resource "google_project_iam_member" "logging_service_account_role" {
  count  = length(local.logging_sa_roles)
  role   = element(local.logging_sa_roles, count.index)
  member = google_logging_project_sink.sample_bq_sink.writer_identity
}
