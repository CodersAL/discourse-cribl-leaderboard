CREATE OR REPLACE VIEW "leaderboard_quarter_ranking_view" AS
SELECT
  leaderboard_present_view.id
, now()::DATE AS timestamp
, ROW_NUMBER() OVER (ORDER BY leaderboard_present_view.points DESC) mrank
, username
, name
, avatar_template
, active
, leaderboard_quarter_points_view.points points
FROM
  leaderboard_present_view
  INNER JOIN leaderboard_quarter_points_view ON leaderboard_present_view.id = leaderboard_quarter_points_view.id
WHERE leaderboard_present_view.points > 0
ORDER BY leaderboard_present_view.points DESC
