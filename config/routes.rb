Rails.application.routes.draw do
  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]
  get 'users/profile'

  resources :topics do
    resources :bookmarks, only: [:create, :new]
  end

  resources :bookmarks, only: [:index, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
  end

  devise_for :users

  resources :users, only: [:update, :index, :show]

  get 'welcome/index'
  get 'welcome/about'

  root to: 'welcome#index'

  post :incoming, to: 'incoming#create'
end
