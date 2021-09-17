resource "google_monitoring_notification_channel" "default" {
    display_name = "DevNotification"
    enabled      = true
    labels       = {
        "auth_token"   = ""
        "channel_name" = "#dev-notification"
    }
    project      = data.google_client_config.current.project
    type         = "slack"
    user_labels  = {}

    timeouts {}
}