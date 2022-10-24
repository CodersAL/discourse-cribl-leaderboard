CREATE TABLE IF NOT EXISTS leaderboard_scores (
                                                id int generated always as identity primary key ,
                                                index_date date null,
                                                user_id int null, points int null
);
CREATE INDEX IF NOT EXISTS index_leaderboard_scores_index_date on leaderboard_scores (index_date);
CREATE INDEX IF NOT EXISTS index_leaderboard_scores_user_id on leaderboard_scores (user_id);
