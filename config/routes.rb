Rails.application.routes.draw do

  resources :topics do
    resources :bookmarks, only: [:create, :new]
  end

  resources :bookmarks, only: [:edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
  end

  devise_for :users

  get 'welcome/index'
  get 'welcome/about'

  root to: 'welcome#index'

  post :incoming, to: 'incoming#create'
end
