class ::CriblLeaderboard::RequestDataController < ::ApplicationController

  def todays
    raise Discourse::InvalidAccess.new unless current_user
    render json: ::CriblLeaderboard::AthenaQueries.todays
  end

  def quarters
    raise Discourse::InvalidAccess.new unless current_user
    render json: ::CriblLeaderboard::AthenaQueries.quarters
  end

  def custom
    raise Discourse::InvalidAccess.new unless current_user

    start_date = SiteSetting.cribl_leaderboard_custom_start_date
    end_date = SiteSetting.cribl_leaderboard_custom_end_date

    results = ::CriblLeaderboard::AthenaQueries.custom_date_range(start_date,end_date)
    render json: results
  end
end
