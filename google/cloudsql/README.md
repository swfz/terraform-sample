# CloudSQL (Private mode)

VPCとCloudSQL(PrivateIP)を構築するためのTerraform

APIの有効化などはGUIからやった(CLIでの実行手順用意)

とりあえず作っただけ

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

## ToDo
- 初期データの入れ込み
- cloudsql_proxy経由での接続
- CloudFunctions等からの接続
