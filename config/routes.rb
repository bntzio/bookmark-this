Rails.application.routes.draw do

  get 'users/show'

  resources :topics do
    resources :bookmarks, only: [:create, :new]
  end

  resources :bookmarks, only: [:edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
  end

  devise_for :users

  resources :users, only: [:show]

  get 'welcome/index'
  get 'welcome/about'

  root to: 'welcome#index'

  post :incoming, to: 'incoming#create'
end
