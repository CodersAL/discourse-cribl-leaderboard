CREATE OR REPLACE VIEW "leaderboard_quarter_points_view" AS
SELECT
  user_id as id
, sum(points) points
FROM
  leaderboard_scores
WHERE date_trunc('quarter', index_date) = date_trunc('quarter', now())
GROUP BY 1;
