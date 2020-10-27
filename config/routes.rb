Rails.application.routes.draw do
  devise_for :users
  root 'game/spa#index'

  namespace :game do
    root to: 'spa#index'
  end
end
