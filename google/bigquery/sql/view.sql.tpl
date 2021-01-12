SELECT
m.classification,
m.name,
m.status,
m.column1,
r.dt,
r.value1
FROM ${dataset_id}.report r JOIN ${dataset_id}.metadata m ON(m.metadata_id = r.metadata_id AND m.classification = r.classification)