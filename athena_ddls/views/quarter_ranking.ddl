CREATE OR REPLACE VIEW "quarter_ranking" AS 
SELECT
  CAST("now"() AS date) timestamp
, "row_number"() OVER (ORDER BY leaderboard_present.points DESC) mrank
, id
, username
, name
, avatar_template
, active
, quarter_points.points points
FROM
  (leaderboard_present
INNER JOIN quarter_points ON (id = user_id))
WHERE (leaderboard_present.points > 0)
ORDER BY leaderboard_present.points DESC
