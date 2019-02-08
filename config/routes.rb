Rails.application.routes.draw do
  resources :item_requests, only: [:new, :create]
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ActionCable.server => '/cable'
  
  devise_for :users, controllers: {sessions: "sessions", registrations: 'registrations'}
  get 'welcome/index'

  get '/home', to: 'users#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users

  get 'items/map' => 'items#map'
  get 'items/item_returned' => 'items#item_returned'
  get 'items/hide_item_from_listings' => 'items#hide_item_from_listings'
  get 'items/unhide_item_from_listings' => 'items#unhide_item_from_listings'
  get 'items/delete_item_from_listings' => 'items#delete_item_from_listings'
  
  post 'connections' => 'connections#create' 
  delete 'connections/:id' => 'connections#destroy', as: 'follow'

  resources :items
  resources :reviews


  get 'requests/approve_request' => 'requests#approve_request'
  get 'requests/decline_request' => 'requests#decline_request'
  get 'requests/active_and_done' => 'requests#active_and_done'
  resources :users do
     resources :reviews
   end
   
  resources :requests

  get 'requests', to: 'notices#index'
  get '/set_notification_read', to: 'notices#set_notification_read'

  root 'welcome#index'
end
