CREATE EXTERNAL TABLE `points`(
  `_time` double COMMENT 'from deserializer', 
  `cribl_pipe` string COMMENT 'from deserializer', 
  `event` string COMMENT 'from deserializer', 
  `notes` string COMMENT 'from deserializer', 
  `points` string COMMENT 'from deserializer', 
  `user_id` int COMMENT 'from deserializer', 
  `partition_0` string COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.openx.data.jsonserde.JsonSerDe' 
WITH SERDEPROPERTIES ( 
  'paths'='_time,cribl_pipe,event,notes,points,user_id') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://merefield-athena-test/source_data/points'
TBLPROPERTIES (
  'last_modified_by'='hadoop', 
  'last_modified_time'='1648839916', 
  'numFiles'='20', 
  'numRows'='-1', 
  'rawDataSize'='-1', 
  'totalSize'='7954', 
  'transient_lastDdlTime'='1649960119')
