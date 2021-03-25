Rails.application.routes.draw do


#devise関連
devise_for :users, :controllers => {
  :registrations => 'devise/users/registrations',
  :sessions => 'devise/users/sessions',
  :passwords => 'devise/users/passwords'
} 

devise_scope :user do
  get "user/:id", :to => "users/registrations#detail"
  get "signup", :to => "users/registrations#new"
  get "login", :to => "users/sessions#new"
  get "logout", :to => "users/sessions#destroy"
  get "password", :to => "users/passwords#new" 
end

#Adminのdevise
devise_for :admins, :controllers => {
  :registrations => 'devise/admins/registrations',
  :sessions => 'devise/admins/sessions',
  :passwords => 'devise/admins/passwords'
}



#Top画面
root to: 'public/homes#top'
get '/about' => 'public/homes#about'

#scope module: :public doでpublicフォルダへまとめる。※URLにpublicがつくことはない
scope module: :public do
  
  get 'search/search'
  
  resources :items, only: [:index, :show]
  
  delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
  resources :cart_items, only: [:index, :create, :destroy, :destroy_all, :update]
  
  
  get 'orders/thanks' => 'orders#thanks'
  resources :orders, only: [:show, :index, :new, :create] do
    collection do
      post :confirm
      post :pay
    end
  end
  
  get 'users/:id/newpassword' => 'users#newpassword'
  get 'users/unsubscribe' => 'users#unsubscribe'
  patch 'users/withdraw' => 'users#withdraw'
  resources :users, only: [:update, :show, :edit]
  
  resources :deliveries, only: [:update, :index, :create, :destroy, :edit]
  
end

#devise以外のadminを下にまとめる

namespace :admin do
  resources :items, only: [:index, :create, :new, :update, :destroy, :show]
end

namespace :admin do
  resources :genres, only: [:index, :create, :new, :update, :destroy, :show, :edit]
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
