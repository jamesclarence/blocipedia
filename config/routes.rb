Rails.application.routes.draw do

  devise_for :users
  resources :wikis
  resources :charges

  root to: 'welcome#index'
end
