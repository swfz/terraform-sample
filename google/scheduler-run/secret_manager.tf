resource "google_secret_manager_secret_iam_binding" "binding" {
  project = google_cloud_run_service.default.project
  secret_id = "sample-secret"
  role = "roles/secretmanager.secretAccessor"
  members = [
    format("serviceAccount:%s", google_service_account.run_invoker.email)
  ]
}