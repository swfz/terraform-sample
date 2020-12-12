# CloudRunを実行するサービスアカウント
resource google_service_account run_invoker {
  project      = local.project
  account_id   = "cloud-run-invoker-sa"
  display_name = "Cloud Run Invoker Service Account"
}

# Cloud Storageを操作するための権限
resource google_storage_bucket_iam_binding run_invoker {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.run_invoker.email}"
  ]
}

# シークレットマネージャーの情報を読むための権限
resource google_secret_manager_secret_iam_binding run_invoker {
  project   = local.project
  secret_id = "sample-secret"
  role      = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:${google_service_account.run_invoker.email}"
  ]
}

# CloudRunを実行するためのポリシー
data google_iam_policy invoker {
  binding {
    role = "roles/run.invoker"
    members = [
      "serviceAccount:${google_service_account.run_invoker.email}"
    ]
  }
}

resource google_cloud_run_service_iam_policy run_policy {
  location    = google_cloud_run_service.default.location
  project     = local.project
  service     = google_cloud_run_service.default.name
  policy_data = data.google_iam_policy.invoker.policy_data
}
