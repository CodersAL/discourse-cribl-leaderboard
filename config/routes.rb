# frozen_string_literal: true

Discourse::Application.routes.append do
  mount ::CriblLeaderboard::Engine, at: 'cribl_leaderboard'
end

::CriblLeaderboard::Engine.routes.draw do
  get '/todays' => 'request_data#todays'
  get '/todays/:user_id' => 'request_data#todays'
  get '/quarters' => 'request_data#quarters'
  get '/custom' => 'request_data#custom'
end
