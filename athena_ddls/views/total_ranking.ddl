CREATE OR REPLACE VIEW "total_ranking" AS 
SELECT
  CAST("now"() AS date) timestamp
, "row_number"() OVER (ORDER BY points DESC) mrank
, id
, username
, name
, points
FROM
  leaderboard_present
WHERE (points > 0)
ORDER BY points DESC
