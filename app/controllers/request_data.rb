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
    params = self.custom_daterange_params

    results = ::CriblLeaderboard::AthenaQueries.custom_date_range(params[:start_date],params[:end_date])
    render json: results
  end

  def custom_daterange_params
    params.permit(:start_date, :end_date)
  end
end
