CREATE OR REPLACE VIEW "leaderboard_total_ranking_view" AS
SELECT
  leaderboard_present_view.id
, now()::DATE AS timestamp
, row_number() OVER (ORDER BY leaderboard_yesterdays_points_view.points DESC) mrank
, username
, name
, avatar_template
, active
, leaderboard_yesterdays_points_view
FROM
  leaderboard_present_view
  INNER JOIN leaderboard_yesterdays_points_view ON leaderboard_present_view.id = leaderboard_yesterdays_points_view.id
WHERE leaderboard_present_view.points > 0
ORDER BY leaderboard_yesterdays_points_view DESC
