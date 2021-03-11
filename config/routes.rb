Rails.application.routes.draw do
  
  get 'cart_items/index'
  get 'cart_items/create'
  get 'cart_items/destroy'
  get 'cart_items/destroy_all'
  get 'cart_items/update'
  root to: 'homes#top'
  get '/about' => 'homes#about'
  
  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions',
  :passwords => 'users/passwords'
} 

devise_scope :user do
  get "user/:id", :to => "users/registrations#detail"
  get "signup", :to => "users/registrations#new"
  get "login", :to => "users/sessions#new"
  get "logout", :to => "users/sessions#destroy"
  get "password", :to => "users/passwords#new" 
end

resources :items, only: [:index, :show]

resources :cart_items, only: [:index, :create, :destroy, :destroy_all, :update]

namespace :admin do
  resources :items, only: [:index, :create, :new, :update, :destroy, :show]
end

namespace :admin do
  resources :genres, only: [:index, :create, :new, :update, :destroy, :show]
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
