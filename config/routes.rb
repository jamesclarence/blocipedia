Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show, :index] do
    post 'premium_to_standard' => 'users#premium_to_standard', as: :premium_to_standard
  end

  resources :wikis do
    resources :collaborators
  end
  resources :charges
  

  root to: 'welcome#index'
end
