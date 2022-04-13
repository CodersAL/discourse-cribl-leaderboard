class ::CriblLeaderboard::RequestDataController < ::ApplicationController

  def todays
    raise Discourse::InvalidAccess.new unless current_user
    params.permit(:user_id)

    user_id = params[:user_id] || nil

    # render json: ::CriblLeaderboard::AthenaQueries.todays(user_id)

    render json: {
      "request_data": [
        {
          "timestamp": "2022-04-12",
          "mrank": 1,
          "yesterdays_rank": 10,
          "daily_rank_move": 9,
          "id": 22,
          "username": "keegan",
          "name": "Keegan George",
          "avatar_template": "/user_avatar/localhost/keegan/{size}/5_2.png",
          "active": true,
          "todays_points": 43
        }
        # {
        #   "timestamp": "2022-04-12",
        #   "mrank": 2,
        #   "yesterdays_rank": 19,
        #   "daily_rank_move": 17,
        #   "id": 2,
        #   "username": "jason",
        #   "name": "Jason Stathom",
        #   "avatar_template": "/user_avatar/localhost/jason/{size}/9_2.png",
        #   "active": true,
        #   "todays_points": 42
        # },
        # {
        #   "timestamp": "2022-04-12",
        #   "mrank": 3,
        #   "yesterdays_rank": 16,
        #   "daily_rank_move": 13,
        #   "id": 14,
        #   "username": "stallone",
        #   "name": "Sylvester Stallone",
        #   "avatar_template": "/user_avatar/localhost/stallone/{size}/10_2.png",
        #   "active": true,
        #   "todays_points": 38
        # },
        # {
        #   "timestamp": "2022-04-11",
        #   "mrank": 4,
        #   "yesterdays_rank": 2,
        #   "daily_rank_move": -2,
        #   "id": 17,
        #   "username": "arnold",
        #   "name": "Arnold Schwarzenegger",
        #   "avatar_template": "/user_avatar/localhost/arnold/{size}/8_2.png",
        #   "active": true,
        #   "todays_points": 38
        # }
      ]
    }
    
  end

  def quarters
    raise Discourse::InvalidAccess.new unless current_user
    # render json: ::CriblLeaderboard::AthenaQueries.quarters

    render json: {
      "request_data": [
        {
          "timestamp": "2022-04-11",
          "mrank": 1,
          "id": 22,
          "username": "keegan",
          "name": "Keegan George",
          "avatar_template": "/user_avatar/localhost/keegan/{size}/5_2.png",
          "active": true,
          "quarter_points": 92
        },
        {
          "timestamp": "2022-04-11",
          "mrank": 2,
          "id": 2,
          "username": "jason",
          "name": "Jason Stathom",
          "avatar_template": "/user_avatar/localhost/jason/{size}/9_2.png",
          "active": true,
          "quarter_points": 74
        },
        {
          "timestamp": "2022-04-11",
          "mrank": 3,
          "id": 14,
          "username": "stallone",
          "name": "Sylvester Stallone",
          "avatar_template": "/user_avatar/localhost/stallone/{size}/10_2.png",
          "active": true,
          "quarter_points": 70
        },
        {
          "timestamp": "2022-04-11",
          "mrank": 4,
          "id": 17,
          "username": "arnold",
          "name": "Arnold Schwarzenegger",
          "avatar_template": "/user_avatar/localhost/arnold/{size}/8_2.png",
          "active": true,
          "quarter_points": 67
        }
      ]
    }
  end

  def custom
    raise Discourse::InvalidAccess.new unless current_user

    start_date = SiteSetting.cribl_leaderboard_custom_start_date
    end_date = SiteSetting.cribl_leaderboard_custom_end_date

    results = ::CriblLeaderboard::AthenaQueries.custom_date_range(start_date,end_date)
    # render json: results
    render json: {
      "request_data": [
        {
          "timestamp": "2022-04-11",
          "mrank": 1,
          "id": 22,
          "username": "keegan",
          "name": "Keegan George",
          "avatar_template": "/user_avatar/localhost/keegan/{size}/5_2.png",
          "active": true,
          "points": 75
        },
        {
          "timestamp": "2022-04-11",
          "mrank": 2,
          "id": 2,
          "username": "jason",
          "name": "Jason Stathom",
          "avatar_template": "/user_avatar/localhost/jason/{size}/9_2.png",
          "active": true,
          "points": 43
        },
        {
          "timestamp": "2022-04-11",
          "mrank": 3,
          "id": 14,
          "username": "stallone",
          "name": "Sylvester Stallone",
          "avatar_template": "/user_avatar/localhost/stallone/{size}/10_2.png",
          "active": true,
          "points": 27
        },
        {
          "timestamp": "2022-04-11",
          "mrank": 4,
          "id": 17,
          "username": "arnold",
          "name": "Arnold Schwarzenegger",
          "avatar_template": "/user_avatar/localhost/arnold/{size}/8_2.png",
          "active": true,
          "points": 67
        }
      ]
    }
  end
end
