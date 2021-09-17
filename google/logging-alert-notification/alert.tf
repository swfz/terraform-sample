resource "google_monitoring_alert_policy" "sample" {
  display_name = "My Alert Policy"
  combiner     = "OR"
  conditions {
    display_name = "test condition"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/log_entry_count\" resource.type=\"workflows.googleapis.com/Workflow\" metric.label.\"severity\"=\"WARNING\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 1
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.default.id
  ]
}
