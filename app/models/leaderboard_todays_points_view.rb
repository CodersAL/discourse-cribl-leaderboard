# frozen_string_literal: true

class LeaderboardTodaysPointsView < ActiveRecord::Base
  self.table_name = 'leaderboard_todays_points_view'
  self.primary_key = "id"
end
