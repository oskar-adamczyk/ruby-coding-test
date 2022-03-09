# frozen_string_literal: true

Rails.application.routes.draw do
  resources :leaderboards do
    scope module: :leaderboards do
      resources :scores, only: %i[create]
    end
  end

  resources :leaderboard_entries, only: [] do
    scope module: :leaderboard_entries do
      resources :scores, only: %i[destroy]
    end
  end

  root to: "leaderboards#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
