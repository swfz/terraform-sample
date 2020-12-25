# MERGE構文

## MERGEでUPSERTとDELETEも合わせて実行できるのか

### 事前準備

使用するテーブル
- metadata

前提としてterraformで`metadata`,`metadata_tmp`のテーブルを作成済みとする

### 要件

statusを`enable`,`disable`を用意した

`rejected`に変化したものに関してはMERGE後DELETEしたい

次のようにtmpに入れるデータはAクラスのデータのみとした

- changes.ndjson

1,A,hoge,enable -> column1更新(c3 -> c4)
3,A,piyo,enable -> column1更新(c3 -> c4)
5,A,bar,rejected -> 削除
7,A,new,enable,c4 -> 追加

なのでB,Cのレコードに関しては変化なしが望まれる挙動

### 削除
Aクラスのレコードのみを対象として集計を行った結果`bar`は削除対象

5,A,barのstatusを`rejected`にする

### 追加

7,newを追加する

### metadataテーブルの初期データ

```shell
bq load --replace --source_format=NEWLINE_DELIMITED_JSON 'sample_dataset.metadata' ./before.ndjson
```


### tmpテーブルへのデータ追加

```shell
bq load --replace --source_format=NEWLINE_DELIMITED_JSON 'sample_dataset.metadata_tmp' ./changes.ndjson
```

MERGE構文を使ってUPSERT+DELETEを行えるか試す


```shell
bq query --format json < query.sql
```

- rejectedの行は削除
- Aクラスのレコードはc3 -> c4へ
- name: newのレコードは追加

無事INSERT,UPDATE,DELETEを1つのMERGE構文のみで実現できた

とても便利!!!
