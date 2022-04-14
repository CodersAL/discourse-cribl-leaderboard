CREATE OR REPLACE VIEW "todays_ranking_with_move" AS 
SELECT
  CAST("now"() AS date) timestamp
, todays_ranking.mrank
, yesterdays_ranking.mrank yesterdays_rank
, (COALESCE(yesterdays_ranking.mrank, 0) - todays_ranking.mrank) daily_rank_move
, todays_ranking.id id
, todays_ranking.username username
, todays_ranking.name name
, todays_ranking.avatar_template avatar_template
, todays_ranking.active active
, todays_ranking.points
FROM
  (todays_ranking
INNER JOIN yesterdays_ranking ON (todays_ranking.id = yesterdays_ranking.id))
ORDER BY todays_ranking.mrank ASC
