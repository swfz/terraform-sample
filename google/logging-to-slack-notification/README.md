# logging-to-slack-notification


## 環境設定(Terraform)

適切な環境変数を設定する

```shell
export GOOGLE_PROJECT=xxx-project
export GOOGLE_REGION=us-central1
```


- 事前の認証情報のセット

```
gcloud auth application-default login
```

- apply

```shell
$ terraform apply
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

project = "xxx-project-111111"
pubsub-topic-name = "sample-log-topic"
region = "us-central1"
```

`pubsub-topic-name`を事項で使う

```
export TOPIC_NAME=sample-log-topic
```

## 通知関数のデプロイ

- 環境変数のセット

```
export SLACK_WEBHOOK_URL=.....
```

- Functionsのデプロイ

```
$ cd functions
$ gcloud functions deploy slackNotification --trigger-topic=${TOPIC_NAME} --runtime nodejs12 --set-env-vars SLACK_WEBHOOK_URL=${SLACK_WEBHOOK_URL}
```
