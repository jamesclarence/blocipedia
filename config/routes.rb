Rails.application.routes.draw do

  devise_for :users
  resources :wikis

  root to: 'welcome#index'
end
