CREATE OR REPLACE VIEW "leaderboard_todays_ranking_view" AS
SELECT
  leaderboard_present_view.id id
, now()::DATE as timestamp
, row_number() OVER (ORDER BY leaderboard_todays_points_view.points DESC) mrank
, leaderboard_present_view.username username
, leaderboard_present_view.name
, leaderboard_present_view.avatar_template
, leaderboard_present_view.active
, leaderboard_todays_points_view.points
FROM
  leaderboard_present_view
  INNER JOIN leaderboard_todays_points_view ON leaderboard_present_view.id = leaderboard_todays_points_view.id
  LEFT JOIN leaderboard_yesterdays_ranking_view ON leaderboard_present_view.id = leaderboard_yesterdays_ranking_view.id
WHERE (leaderboard_present_view.points > 0)
ORDER BY points DESC
