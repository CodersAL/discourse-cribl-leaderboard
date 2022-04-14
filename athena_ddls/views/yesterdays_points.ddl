CREATE OR REPLACE VIEW "yesterdays_points" AS 
SELECT
  user_id
, "sum"(CAST(points AS int)) yesterdays_points
FROM
  points
WHERE ("to_unixtime"(CAST("split_part"(CAST("from_unixtime"(_time) AS varchar(255)), ' ', 1) AS date)) = "to_unixtime"((current_date - INTERVAL  '1' DAY)))
GROUP BY 1
