# frozen_string_literal: true

class ::CriblLeaderboard::AthenaQueries

  @@conn = nil
  
  def self.todays(user_id)
    if user_id.nil?
      cache_key = "cribl_todays_ranking_with_move"
      sql = "SELECT * FROM todays_ranking_with_move"
    else
      cache_key = "cribl_todays_ranking_with_move_#{user_id}"
      sql = "SELECT * FROM todays_ranking_with_move WHERE id = #{user_id}"
    end

    result = Discourse.cache.fetch(cache_key, expires_in: 1.minutes) do
      return self.run_query(sql)
    end
  end

  def self.quarters
    cache_key = "cribl_quarter_ranking"
    sql = "SELECT * FROM quarter_ranking"

    result = Discourse.cache.fetch(cache_key, expires_in: 1.hours) do
      return self.run_query(sql)
    end
  end

  def self.custom_date_range(start_date, end_date)
    cache_key = "cribl_custom_date_range_#{start_date.to_s}_to_#{end_date.to_s}"

    result = Discourse.cache.fetch(cache_key, expires_in: 1.hours) do
      self.run_query <<-SQL
        SELECT id, "ROW_NUMBER"() OVER (ORDER BY points DESC) mrank, username, name, avatar_template, active, sub.points
        FROM users INNER JOIN (SELECT user_id, SUM(CAST(points AS INT)) AS points FROM points
        WHERE _time > "to_unixtime"(DATE('#{start_date}'))
        AND _time < "to_unixtime"(DATE('#{end_date}'))
        GROUP BY user_id) sub
        ON sub.user_id = id
        ORDER BY points DESC
      SQL
    end
  end

  def self.run_query(sql)
    conn = self.confirm_connection

    return false if !conn

    query = conn.execute(sql)

    query.wait

    if query.to_a.count > 1 then
      return query.to_h
    else
      return []
    end
  end

  def self.confirm_connection
    if @@conn.nil? && !SiteSetting.cribl_leaderboard_s3_query_database_name.blank? then
      @@conn = Athens::Connection.new(database: SiteSetting.cribl_leaderboard_s3_query_database_name)
    else
      if @@conn.nil?
        return false
      else
        return @@conn
      end
    end
  end 
end
