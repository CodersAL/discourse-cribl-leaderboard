CREATE OR REPLACE VIEW "leaderboard_present" AS 
SELECT
  users.id
, users.username
, users.name
, users.avatar_template
, users.active
, "sum"(CAST(points.points AS int)) points
FROM
  (users
INNER JOIN points ON (users.id = points.user_id))
GROUP BY 1, 2, 3, 4, 5
ORDER BY 6 DESC
