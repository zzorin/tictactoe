Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#index'

  namespace :player_menu do
    root to: 'spa#index'
  end

  resources :games do
  end
end
