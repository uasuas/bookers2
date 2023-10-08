Rails.application.routes.draw do
  
  get 'users/new'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  root 'homes#top'
  
  resources :books, only: [:new, :create, :index, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
