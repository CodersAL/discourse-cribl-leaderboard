CREATE OR REPLACE VIEW "leaderboard_present_view" AS
SELECT
  users.id
, users.username
, users.name
, '' AS avatar_template
, users.active
, SUM(leaderboard_scores.points) points
FROM
  users
  LEFT OUTER JOIN leaderboard_scores ON users.id = leaderboard_scores.user_id
GROUP BY 1, 2, 3, 4, 5
ORDER BY 6 DESC
