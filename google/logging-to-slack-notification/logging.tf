resource "google_logging_project_sink" "sample_sink" {
  name                   = "to-pubsub"
  destination            = "pubsub.googleapis.com/projects/${data.google_client_config.current.project}/topics/${google_pubsub_topic.logging.name}"
  filter                 = "resource.type = workflows.googleapis.com/Workflow AND severity >= WARNING"
  unique_writer_identity = true
}
