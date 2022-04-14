CREATE OR REPLACE VIEW "todays_points" AS 
SELECT
  user_id
, "sum"(CAST(points AS int)) points
FROM
  points
WHERE ("to_unixtime"(CAST("split_part"(CAST("from_unixtime"(_time) AS varchar(255)), ' ', 1) AS date)) = "to_unixtime"(current_date))
GROUP BY 1
