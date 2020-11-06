# CloudScheduler + CloudRun

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

別途リポジトリでイメージのプッシュまでを行う

```shell
export PROJECT=$(gcloud config get-value project)
gcloud builds submit --tag gcr.io/$PROJECT/sample-run
```

```shell
terraform init
terraform plan -var-file default.tfvars
terraform apply -var-file default.tfvars -auto-approve
```

## デプロイ
- イメージ変更時
terraform applyでcloud runのdeployを叩きたい

イメージに変更がある場合はコミットハッシュをenvに設定する

```
terraform apply -var-file default.tfvars -auto-approve -var="short_sha=$(git rev-parse --short HEAD)"
```

- 構成変更時

run deployが走るだけ

コミットハッシュは空になる


## ToDo
- スケールさせる場合のパターン 1 container 1 scheduler
- invokerにsecret managerの権限付与
- backend gcs
