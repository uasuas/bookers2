Rails.application.routes.draw do


  root 'homes#top'

  devise_for :users

  get '/home/about' => "homes#about", as: "about"
  get 'search' => "searches#search"

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :index, :show, :edit, :update]
  # いいね機能
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :users, only: [:index, :show, :edit, :update, :new] do
    member do
      get :favorites
    end
  end
  # DM機能
  resources :chats, only: [:show, :create, :destroy]
  # グループ機能
  resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
  end

  resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

  get "tags/search", to: "tags#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end