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
  get 'search/genre_search'
  
  resources :items, only: [:index, :show] do
    resources :reviews
  end
  
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

#お問い合わせのルーティング
post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
post 'contacts/back', to: 'contacts#back', as: 'back'
get 'done', to: 'contacts#done', as: 'done'
resources :contacts, only: [:new, :create]

#devise以外のadminを下にまとめる

namespace :admin do
  resources :items, only: [:index, :create, :new, :update, :destroy, :show, :edit]
end

namespace :admin do
  resources :genres, only: [:index, :create, :new, :update, :destroy, :show, :edit]
end

namespace :admin do
  resources :users, only: [:index, :edit, :update, :show]
end

namespace :admin do
  resources :orders, only: [:index, :show, :update]
end

namespace :admin do
  resources :order_details, only: [:update]
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
