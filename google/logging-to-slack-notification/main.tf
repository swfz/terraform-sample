data "google_client_config" "current" {
}

output "region" {
  value = data.google_client_config.current.region
}

output "project" {
  value = data.google_client_config.current.project
}
