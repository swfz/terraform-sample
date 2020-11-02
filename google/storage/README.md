# Create Storage

## サービスアカウント

GUIからある程度の権限をもたせて作成した

キーファイルのパスを`GOOGLE_CLOUD_KEYFILE_JSON`環境変数に格納する

```shell
export GOOGLE_CLOUD_KEYFILE_JSON=path_to/account.json
```

```shell
terraform init
terraform plan
terraform apply
```