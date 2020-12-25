# BigQuery

BigQueryのデータセットやテーブルを管理するためのディレクトリ


## simple
- metadata

## partitioned
- report

## view

## materialized_view

## shpreadsheets source

## queryの管理

google_bigquery_jobで初期データ生成用のSQLを流し込むJobを生成できる

`./sql`以下に用意してそれをJob登録時に使用する

Jobの生成までしか担保していない

JobIDが同じだと重複していると怒られるのでrandom_idなどを使って実行毎にIDが変わるようにしている

## scheduled query

## UDF

## 課題

初期値の入れ込みでJobを使用してSQLを入れ込んでいるが

何故かmodeを`REQUIRED`にしているのになぜか`NULLABLE`になっている…

WRITE_TRUNCATEでクエリ実行している場合は起きる

WRITE_EMPTYの場合は大丈夫そうだがデータを書き換えて再実行してもJob側でエラーが発生していて更新できない

WRITE_APPENDの場合は文字通り追記なので実行するたびにデータが追記される

あとrandomでJobIDをランダムにしようとしたがtfstateで管理しているのか別のIDにはならない模様

まぁそりゃそうだよなって感じだけど、だとしたらこれそんなに使いみちが…という気持ちになっている