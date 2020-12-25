WITH sample AS(
  SELECT * FROM UNNEST(ARRAY<STRUCT<metadata_id INT64, classification STRING, name STRING, status STRING, column1 STRING>>
    [
      (1, "A", "hoge", "enable", "c3"),
      (2, "B", "fuga", "enable", "c3"),
      (3, "A", "piyo", "enable", "c3"),
      (4, "B", "foo", "disable", "c3"),
      (5, "A", "bar", "disable", "c3"),
      (6, "C", "baz", "enable", "c3")
    ]
  )
)
SELECT * FROM sample