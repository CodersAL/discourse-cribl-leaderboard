CREATE OR REPLACE VIEW "leaderboard_todays_ranking_with_move_view" AS
SELECT
  leaderboard_todays_ranking_view.id id
,  now()::DATE AS timestamp
, leaderboard_todays_ranking_view.mrank
, leaderboard_yesterdays_ranking_view.mrank yesterdays_rank
, (COALESCE(leaderboard_yesterdays_ranking_view.mrank, 0) - leaderboard_todays_ranking_view.mrank) daily_rank_move
, leaderboard_todays_ranking_view.username username
, leaderboard_todays_ranking_view.name
, leaderboard_todays_ranking_view.avatar_template avatar_template
, leaderboard_todays_ranking_view.active active
, leaderboard_todays_ranking_view.points
FROM
  leaderboard_todays_ranking_view
  INNER JOIN leaderboard_yesterdays_ranking_view ON leaderboard_todays_ranking_view.id = leaderboard_yesterdays_ranking_view.id
ORDER BY leaderboard_todays_ranking_view.mrank ASC
