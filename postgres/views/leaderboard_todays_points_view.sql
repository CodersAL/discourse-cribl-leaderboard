CREATE OR REPLACE VIEW "leaderboard_todays_points_view" AS
SELECT
  user_id as id
, SUM(CAST(points AS int)) points
FROM
  leaderboard_scores
WHERE CAST(INDEX_DATE AS DATE) = CAST(NOW() AS DATE)
GROUP BY 1;
