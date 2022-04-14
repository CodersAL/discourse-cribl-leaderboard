CREATE OR REPLACE VIEW "todays_ranking" AS 
SELECT
  CAST("now"() AS date) timestamp
, "row_number"() OVER (ORDER BY todays_points.points DESC) mrank
, leaderboard_present.id id
, leaderboard_present.username username
, leaderboard_present.name name
, leaderboard_present.avatar_template
, leaderboard_present.active
, todays_points.points
FROM
  ((leaderboard_present
INNER JOIN todays_points ON (leaderboard_present.id = todays_points.user_id))
LEFT JOIN yesterdays_ranking ON (leaderboard_present.id = yesterdays_ranking.id))
WHERE (leaderboard_present.points > 0)
ORDER BY points DESC
