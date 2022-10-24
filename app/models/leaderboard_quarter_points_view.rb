# frozen_string_literal: true

class LeaderboardQuarterRankingView < ActiveRecord::Base
  # because we want to use the 'type' column and don't want to use STI
  self.inheritance_column = nil
  self.table_name = "leaderboard_quarter_ranking_view"
  self.primary_key = "id"

end
