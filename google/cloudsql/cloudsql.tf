resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database" "database" {
  name     = local.database.name
  charset  = "utf8mb4"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name   = local.database.instance.name
  region = var.region
  database_version = "MYSQL_5_7"

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = local.database.instance.tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc_network.id
    }
  }

  deletion_protection  = "false"
}

resource "google_sql_user" "test_user" {
  name = "hoge"
  instance = google_sql_database_instance.instance.name
  password = "hoge"
  lifecycle {
    ignore_changes = [password]
  }
}