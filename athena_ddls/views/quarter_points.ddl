CREATE OR REPLACE VIEW "quarter_points" AS 
SELECT
  user_id
, "sum"(CAST(points AS int)) points
FROM
  points
WHERE ("quarter"(CAST("split_part"(CAST("from_unixtime"(_time) AS varchar(255)), ' ', 1) AS date)) = "quarter"("now"()))
GROUP BY 1
