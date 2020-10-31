Rails.application.routes.draw do
  devise_for :users
  root 'player_menu/spa#index'

  namespace :player_menu do
    root to: 'spa#index'
  end

  resources :games do
    resources :participants do
      collection do
        get :by_user
      end
    end
  end
end
