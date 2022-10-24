delete from leaderboard_scores where index_date  = now()::DATE;
insert into leaderboard_scores (index_date, user_id, points)
select now()::DATE, user_id, likes_received from user_stats;
