# frozen_string_literal: true

class LeaderboardTodaysRankingView < ActiveRecord::Base
  # because we want to use the 'type' column and don't want to use STI
  self.inheritance_column = nil
  self.table_name = "leaderboard_todays_ranking_view"
  self.primary_key = "id"

end
