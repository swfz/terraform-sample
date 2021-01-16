#standardSQL
MERGE `sample_dataset.metadata` target USING `sample_dataset.metadata_tmp` tmp
ON(target.metadata_id = tmp.metadata_id AND target.classification = tmp.classification AND target.name = tmp.name)
WHEN MATCHED AND tmp.status = 'rejected' THEN
  DELETE
WHEN MATCHED THEN
  UPDATE SET metadata_id = tmp.metadata_id, classification = tmp.classification, name = tmp.name, status = tmp.status, column1 = tmp.column1
WHEN NOT MATCHED THEN
  INSERT ROW
