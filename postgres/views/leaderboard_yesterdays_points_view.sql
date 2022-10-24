CREATE OR REPLACE VIEW "leaderboard_yesterdays_points_view" AS
SELECT
  user_id as id
, SUM(CAST(points AS int)) points
FROM
  leaderboard_scores
WHERE INDEX_DATE::DATE = NOW()::DATE - 1
GROUP BY 1;
