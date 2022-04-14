# frozen_string_literal: true

Discourse::Application.routes.append do
  mount ::CriblLeaderboard::Engine, at: 'cribl'
end

::CriblLeaderboard::Engine.routes.draw do
  get '/leaderboard' => 'leaderboard#index'
  get '/leaderboard/:user_id' => 'leaderboard#index'
end
