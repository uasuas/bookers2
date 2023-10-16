Rails.application.routes.draw do
  root 'homes#top'

  devise_for :users

  get '/home/about' => "homes#about", as: "about"

  resources :books do
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:new, :index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end