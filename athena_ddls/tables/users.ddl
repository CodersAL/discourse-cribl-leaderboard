CREATE EXTERNAL TABLE `users`(
  `id` int COMMENT 'from deserializer', 
  `username` string COMMENT 'from deserializer', 
  `name` string COMMENT 'from deserializer', 
  `avatar_template` string COMMENT 'from deserializer', 
  `active` boolean COMMENT 'from deserializer', 
  `admin` boolean COMMENT 'from deserializer', 
  `moderator` boolean COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.openx.data.jsonserde.JsonSerDe' 
WITH SERDEPROPERTIES ( 
  'paths'='active,admin,avatar_template,id,moderator,name,username') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://merefield-athena-test/source_data/users'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='points-users', 
  'averageRecordSize'='183', 
  'classification'='json', 
  'compressionType'='none', 
  'objectCount'='1', 
  'recordCount'='22', 
  'sizeKey'='4045', 
  'transient_lastDdlTime'='1648638121', 
  'typeOfData'='file')
