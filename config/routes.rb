Rails.application.routes.draw do
  
  root 'homes#top'
  
  resources :books, only: [:new, :create, :index, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
