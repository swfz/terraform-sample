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
region = "us-central1"
```
