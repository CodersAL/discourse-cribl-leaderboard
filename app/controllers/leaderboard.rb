class ::CriblLeaderboard::LeaderboardController < ::ApplicationController
  PAGE_SIZE = 50

  def index
    raise Discourse::InvalidAccess.new unless current_user
    params.permit(:user_id, :page, :format, :period)

    case params[:period]
    when 'all_time'
      success, error, result = ::CriblLeaderboard::PostgresQueries.all_time(params[:user_id] || nil)
    when 'today'
      success, error, result = ::CriblLeaderboard::PostgresQueries.today(params[:user_id] || nil)
    else
      success, error, result = ::CriblLeaderboard::PostgresQueries.quarter(params[:user_id] || nil)
    end

    build_response params, success, error, result
  end

  private def build_load_more_uri(params)
    more_params = params.slice(:period, :user_id).permit!
    page = params[:page].to_i
    more_params[:page] = page + 1

    load_more_uri = URI.parse(leaderboard_path(more_params))
    "#{load_more_uri.path}.json?#{load_more_uri.query}"
  end

  private def build_response(params, success, error, result)
    if success
      result_count = result.length
      page = params[:page].to_i

      data = result[page * PAGE_SIZE, PAGE_SIZE]

      users = User.where(id: data.select { |u| u.id }).to_h { |u| [u.id, u] }

      data.each do |item|
        item.avatar_template = users[item.id] ? users[item.id].avatar_template : ''
      end

      render_json_dump(data: data,
                       meta: {
                         total_rows_leaderboard: result_count,
                         load_more_leaderboard: build_load_more_uri(params)
                       }
      )
    else
      render json: failed_json.merge(errors: error), status: 500
    end
  end

end
