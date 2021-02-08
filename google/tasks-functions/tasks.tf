resource google_cloud_tasks_queue sample_queue {
  name = "sample-queue"
  location = "asia-northeast1"

  rate_limits {
    # 同時実行可能数
    max_concurrent_dispatches = 2
    # 秒間何回まで実行できるか
    max_dispatches_per_second = 2
  }

  retry_config {
    max_attempts = 3
    max_retry_duration = "200s"
    min_backoff = "10s"
    max_backoff = "50s"
    max_doublings = 3
  }
}
