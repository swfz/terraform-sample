resource "google_logging_project_sink" "sample_bq_sink" {
  name                   = "to-bigquery"
  destination            = "bigquery.googleapis.com/projects/${data.google_client_config.current.project}/datasets/logging"
  filter                 = "severity >= INFO"
  unique_writer_identity = true
  bigquery_options {
    use_partitioned_tables = true
  }
}
