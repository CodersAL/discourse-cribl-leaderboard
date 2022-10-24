# frozen_string_literal: true

class ::CriblLeaderboard::PostgresQueries

  @@conn = nil

  @enable_cache = false

  def self.today(user_id)
    get_data = Proc.new {|id| id.nil? ? LeaderboardTodaysRankingView.all : LeaderboardTodaysRankingView.where({id: id})}
    self.return_results(user_id, get_data, "cribl_today_ranking")
  end


  def self.quarter(user_id)
    get_data = Proc.new {|id| id.nil? ? LeaderboardQuarterRankingView.all : LeaderboardQuarterRankingView.where({id: id})}
    self.return_results(user_id, get_data, "cribl_quarter_ranking")
  end


  def self.all_time(user_id)
    get_data = Proc.new {|id| id.nil? ? LeaderboardTotalRankingView.all : LeaderboardTotalRankingView.where({id: id})}
    self.return_results(user_id, get_data, "cribl_all_time_ranking")
  end

  def self.return_results(user_id, get_data, cache_prefix)
    cache_key = self.build_cache_key cache_prefix, user_id
    begin
      if @enable_cache
        result = Discourse.cache.fetch(cache_key, expires_in: 1.hours) do  get_data.call(user_id) end
      else
        result = get_data.call(user_id)
      end

      if result.length > 1 then
        return true, nil, result
      else
        return true, nil, []
      end
    rescue => e
      return false, "#{I18n.t("cribl.errors.failed_query")}: #{e}", []
    end
  end

  def self.build_cache_key key, user_id
    user_id.nil? ? key : "#{key}_#{user_id}"
  end
end
