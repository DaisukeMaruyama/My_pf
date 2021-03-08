Rails.application.routes.draw do
  
  root to: 'homes#top'
  get '/about' => 'homes#about'
  
  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'   
} 

devise_scope :user do
  get "user/:id", :to => "users/registrations#detail"
  get "signup", :to => "users/registrations#new"
  get "login", :to => "users/sessions#new"
  get "logout", :to => "users/sessions#destroy"
end

resources :items, only: [:index, :show]

namespace :admin do
  resources :items, only: [:index, :create, :new, :update, :destroy, :show]
end

namespace :admin do
  resources :genres, only: [:index, :create, :new, :update, :destroy, :show]
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
