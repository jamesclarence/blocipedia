Rails.application.routes.draw do

  get 'users/premium_to_standard'

  devise_for :users
  resources :users, only: [:show, :index] do
    post 'premium_to_standard' => 'users#premium_to_standard', as: :premium_to_standard
  end

  resources :wikis
  resources :charges

  root to: 'welcome#index'
end
