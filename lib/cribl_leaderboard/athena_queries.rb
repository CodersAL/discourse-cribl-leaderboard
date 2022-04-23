# frozen_string_literal: true

class ::CriblLeaderboard::AthenaQueries

  @@conn = nil
  
  def self.today(user_id)
    if user_id.nil?
      cache_key = "cribl_todays_ranking_with_move"
      sql = "SELECT * FROM todays_ranking_with_move"
    else
      cache_key = "cribl_todays_ranking_with_move_#{user_id}"
      sql = "SELECT * FROM todays_ranking_with_move WHERE id = #{user_id}"
    end

    result = Discourse.cache.fetch(cache_key, expires_in: 1.hours) do
      return self.run_query(sql)
    end
  end

  def self.quarter(user_id)
    if user_id.nil?
      cache_key = "cribl_quarter_ranking"
      sql = "SELECT * FROM quarter_ranking"
    else
      cache_key = "cribl_quarter_ranking_#{user_id}"
      sql = "SELECT * FROM quarter_ranking WHERE id = #{user_id}"
    end

    result = Discourse.cache.fetch(cache_key, expires_in: 1.hours) do
      return self.run_query(sql)
    end
  end

  def self.custom(user_id)

    start_date = SiteSetting.cribl_leaderboard_custom_start_date
    end_date = SiteSetting.cribl_leaderboard_custom_end_date

    if user_id.nil?
      cache_key = "cribl_custom_date_range_#{start_date.to_s}_to_#{end_date.to_s}"
    else
      cache_key = "cribl_custom_date_range_#{start_date.to_s}_to_#{end_date.to_s}_user_#{user_id}"
    end

    result = Discourse.cache.fetch(cache_key, expires_in: 1.hours) do
      if user_id.nil?
        self.run_query <<-SQL
          SELECT id, "ROW_NUMBER"() OVER (ORDER BY points DESC) mrank, username, name, avatar_template, active, sub.points
          FROM users INNER JOIN (SELECT user_id, SUM(CAST(points AS INT)) AS points FROM points
          WHERE _time > "to_unixtime"(DATE('#{start_date}'))
          AND _time < "to_unixtime"(DATE('#{end_date}'))
          GROUP BY user_id) sub
          ON sub.user_id = id
          ORDER BY points DESC
        SQL
      else
        self.run_query <<-SQL
          SELECT id, "ROW_NUMBER"() OVER (ORDER BY points DESC) mrank, username, name, avatar_template, active, sub.points
          FROM users INNER JOIN (SELECT user_id, SUM(CAST(points AS INT)) AS points FROM points
          WHERE _time > "to_unixtime"(DATE('#{start_date}'))
          AND _time < "to_unixtime"(DATE('#{end_date}'))
          AND id = #{user_id}
          GROUP BY user_id) sub
          ON sub.user_id = id
          ORDER BY points DESC
        SQL
      end
    end
  end

  def self.run_query(sql)
    success, error, conn = self.confirm_connection

    return false, error, nil if !success

    begin
      query = conn.execute(sql)
      query.wait
      if query.to_a.count > 1 then
        return true, nil, query.to_h
      else
        return true, nil, []
      end
    rescue => e
      return false, "#{I18n.t("cribl.errors.failed_query")}: #{e}", []
    end
  end

  def self.confirm_connection
    if SiteSetting.cribl_leaderboard_s3_query_database_name.blank?
      return false, I18n.t("cribl.errors.blank_database_setting"), nil
    elsif @@conn.nil?
      begin
        @@conn = Athens::Connection.new(database: SiteSetting.cribl_leaderboard_s3_query_database_name)
        return true, nil, @@conn
      rescue => e
        return false, "#{I18n.t("cribl.errors.failed_database_connection")}: #{e}", nil
      end
    else
      return true, nil, @@conn
    end
  end 

  def self.clear_connection
    @@conn = nil
    return I18n.t("cribl.connection.cleared_connection")
  end
end
