resource google_bigquery_dataset default {
  dataset_id    = "sample_dataset"
  friendly_name = "hoge"
  description   = "hoge"
  project       = local.project
  location      = "US"
  labels = {
    env = "dev"
  }
}

resource google_bigquery_table report {
  dataset_id  = google_bigquery_dataset.default.dataset_id
  table_id    = "report"
  schema      = jsonencode(local.schema.report)
  time_partitioning  {
    field = "dt"
    type = "DAY"
  }

  labels = {
    env = "dev"
  }
}

resource google_bigquery_table metadata {
  dataset_id  = google_bigquery_dataset.default.dataset_id
  table_id    = "metadata"
  schema      = jsonencode(local.schema.metadata)

  labels = {
    env = "dev"
  }
}

data template_file metadata_sample_sql {
  template = file("sql/metadata.sql.tpl")
}

resource random_uuid job_id { }

resource google_bigquery_job metadata_sample_data {
  job_id = "metadata_sample_data_job_query-${random_uuid.job_id.result}2"

  labels = {
    env = "dev-sample-value"
  }

  query {
    query = data.template_file.metadata_sample_sql.rendered

    destination_table {
      project_id = google_bigquery_table.metadata.project
      dataset_id = google_bigquery_table.metadata.dataset_id
      table_id = google_bigquery_table.metadata.table_id
    }

    allow_large_results = true
    flatten_results = true

    script_options {
      key_result_statement = "LAST"
    }

    write_disposition = "WRITE_EMPTY"
  }
}
