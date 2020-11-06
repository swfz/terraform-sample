# Pub/Sub + CloudRun

SchedulerとCloudRunを構築するためのTerraform

APIの有効化などはGUIからやった(CLIでの実行手順用意)

## サービスアカウント

GUIからある程度の権限をもたせて作成した

キーファイルのパスを`GOOGLE_CLOUD_KEYFILE_JSON`環境変数に格納する

```shell
export GOOGLE_CLOUD_KEYFILE_JSON=path_to/account.json
```

- build

buildはCD上でやる

## 初期構築

```shell
export PROJECT=$(gcloud config get-value project)
gcloud builds submit --tag gcr.io/$PROJECT/hoge
```

```shell
terraform init
terraform plan -var-file default.tfvars
terraform apply -var-file default.tfvars -auto-approve
```

## デプロイ
build -> latestのIDを渡してterraform applyすればよい？
