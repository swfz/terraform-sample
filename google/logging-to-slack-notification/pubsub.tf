resource "google_pubsub_topic" "logging" {
  name = "sample-log-topic"
}

output "pubsub-topic-name" {
  value = google_pubsub_topic.logging.name
}
