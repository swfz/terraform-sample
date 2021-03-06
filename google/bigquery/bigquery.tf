# sample用のデータセット
resource "google_bigquery_dataset" "default" {
  dataset_id    = "sample_dataset"
  friendly_name = "hoge"
  description   = "hoge"
  project       = local.project
  location      = "US"
  labels = {
    env = "dev"
  }
}

# レポート用テーブル 日付パーティション
resource "google_bigquery_table" "report" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "report"
  schema     = file("schema/report.json")
  time_partitioning {
    field = "dt"
    type  = "DAY"
  }

  labels = {
    env = "dev"
  }
}

# メタデータ用テーブル
resource "google_bigquery_table" "metadata" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "metadata"
  schema     = file("schema/metadata.json")

  labels = {
    env = "dev"
  }
}

# メタデータ用テーブル MERGE用の一時テーブル
resource "google_bigquery_table" "metadata_tmp" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "metadata_tmp"
  schema     = file("schema/metadata.json")

  labels = {
    env = "dev"
  }
}

data "template_file" "metadata_sample_sql" {
  template = file("sql/metadata.sql.tpl")
}

resource "random_uuid" "job_id" {}

# メタデータへの初期データ投入用JOB
resource "google_bigquery_job" "metadata_sample_data" {
  job_id = "metadata_sample_data_job_query-${random_uuid.job_id.result}"

  labels = {
    env = "dev-sample-value"
  }

  query {
    query = data.template_file.metadata_sample_sql.rendered

    destination_table {
      project_id = google_bigquery_table.metadata.project
      dataset_id = google_bigquery_table.metadata.dataset_id
      table_id   = google_bigquery_table.metadata.table_id
    }

    allow_large_results = true
    flatten_results     = true

    script_options {
      key_result_statement = "LAST"
    }

    write_disposition = "WRITE_EMPTY"
  }
}

# view作成用SQL
data "template_file" "view_sql" {
  template = file("sql/view.sql.tpl")
  vars = {
    dataset_id = google_bigquery_dataset.default.dataset_id
  }
}

resource "google_bigquery_table" "joined_view" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "summary"

  view {
    query          = data.template_file.view_sql.rendered
    use_legacy_sql = false
  }
}