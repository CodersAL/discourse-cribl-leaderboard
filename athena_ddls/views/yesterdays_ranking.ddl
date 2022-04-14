CREATE OR REPLACE VIEW "yesterdays_ranking" AS 
SELECT
  CAST("now"() AS date) timestamp
, "row_number"() OVER (ORDER BY yesterdays_points DESC) mrank
, id
, username
, name
, avatar_template
, active
, yesterdays_points
FROM
  (leaderboard_present
INNER JOIN yesterdays_points ON (id = user_id))
WHERE (leaderboard_present.points > 0)
ORDER BY yesterdays_points DESC
