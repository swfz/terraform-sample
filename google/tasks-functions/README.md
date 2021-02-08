# CloudTasks + CloudFunctionsのサンプル

```shell
terraform init
terraform plan
terraform apply
```

## retry_config
- max_attempts
    - 試行回数、-1は無制限再試行

- max_retry_duration
    - 0の場合タスクの経過時間は無制限
    - 失敗したタスクを再試行するための時間制限

- max_attemptsとmax_retry_durationは片方残ってたら適用されるのかな？

- min_backoff,max_backoff
    - 失敗した後min_backoff,max_backoffの期間の間に再試行するようスケジュールされる

- max_doublings
    - 再試行の時間はmax_doublingsの2倍にする
    - タスクの再試行間隔はmin_backoffで始まり、max_doublings回の2倍になり直線的に増加しmax_attempts回までmax_backoffの間隔で再試行します

https://cloud.google.com/tasks/docs/reference/rest/v2/projects.locations.queues?hl=ja#RetryConfig


## CloudFunctions

- deploy

```
$ cd functions
$ gcloud functions deploy helloWorld --runtime=nodejs12 --trigger-http --timeout=540
```

## run tasks
### CLIからのhttp-taskの登録

```shell
gcloud tasks create-http-task sample1 --queue=sample-queue --url=https://asia-northeast1-sample-project-111111.cloudfunctions.net/helloWorld/ --method=POST --body-content='{"hoge":"fuga"}' --oidc-service-account-email=sample-project@sample-project-111111.iam.gserviceaccount.com --oidc-token-audience=https://asia-northeast1-sample-project-111111.cloudfunctions.net/helloWorld/
```

### プログラムからのtask登録

```
$ cd functions
$ node push.js
```
