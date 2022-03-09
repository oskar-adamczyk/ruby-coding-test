# frozen_string_literal: true

Rails.application.routes.draw do
  resources :leaderboards do
    post :add_score, on: :member
    scope module: :leaderboards do
      resources :scores, only: %i[create]
    end
  end

  root to: "leaderboards#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
