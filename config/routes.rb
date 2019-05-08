Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}

  devise_scope :user do
    get '/signout', to: 'devise/sessions#destroy', as: :signout
  end
  
  get 'sessions/new'
  get 'sessions/destroy'
  post 'sessions/create'
  get 'events/delete' => 'events#destroy'
  get 'rsvp_events/delete' => 'rsvp_events#destroy'
  get '/auth/:provider/callback' => "sessions#create"
  #get 'auth/google/callback', to: 'sessions#googleAuth'
  get '/auth/failure' => 'home#index'
  #post '/rsvp_events/create', to: 'rsvp_events#create'
  get 'events/past'  => 'events#past'
  

  #get 'users/new'
  #get 'users/edit'
  #get 'events/new'
  #get 'events/edit'
  #get 'events/index'
  #get 'events/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do 
    resources :events, only: [:show, :index, :new, :edit, :create, :update]
  end 

  resources :events do
     post '/rsvp_events/create', to: 'rsvp_events#create', on: :member
  end
    
  root :to => 'home#index'
end