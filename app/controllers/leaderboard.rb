class ::CriblLeaderboard::LeaderboardController < ::ApplicationController
  PAGE_SIZE = 5

  def index
    raise Discourse::InvalidAccess.new unless current_user
    params.permit(:user_id, :page, :period)

    user_id = params[:user_id] || nil
    period = params[:period] || "today"
    page = params[:page] || 0
    more_params = params.slice(:period, :user_id).permit!
    more_params[:page] = page + 1

    load_more_uri = URI.parse(leaderboard_path(more_params))
    load_more_request_data_json = "#{load_more_uri.path}.json?#{load_more_uri.query}"

    result = ::CriblLeaderboard::AthenaQueries.public_send(period, user_id)

    result_count = result.count

    render_json_dump(data: result[page * PAGE_SIZE, PAGE_SIZE],
      meta: {
         total_rows_leaderboard: result_count,
         load_more_leaderboard: load_more_request_data_json
       }
     )
  end
end
