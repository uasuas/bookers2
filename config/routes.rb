Rails.application.routes.draw do


  root 'homes#top'

  devise_for :users

  get '/home/about', to: "homes#about", as: "about"
  get 'search', to: "searches#search"
  get "tags/search", to: "tags#search"


  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    get "video", to: "books#video", as: "video"
  end

  resources :users, only: [:new, :index, :show, :edit, :update]
  # いいね機能
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings', to: 'relationships#followings', as: 'followings'
    get 'followers', to: 'relationships#followers', as: 'followers'
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
    get "new/mail", to: "groups#new_mail"
    get "send/mail", to: "groups#send_mail"
  end

  # ゲストログイン機能
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end