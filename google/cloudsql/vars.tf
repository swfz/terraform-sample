variable region {}

locals {
  database = {
    name = "my-database"
    instance = {
      name = "swfz-database-name"
      tier = "db-f1-micro"
    }
  }
}