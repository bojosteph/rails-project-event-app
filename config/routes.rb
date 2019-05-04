Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/destroy'
  post 'sessions/create'
  
  get 'rsvp_events/delete' => 'rsvp_events#destroy'
  get '/auth/:provider/callback' => "sessions#create"
  get 'auth/google/callback', to: 'sessions#googleAuth'
  get '/auth/failure' => 'public#index'
  #post '/rsvp_events/create', to: 'rsvp_events#create'

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

  resources :events, only: [:destroy] do
     post '/rsvp_events/create', to: 'rsvp_events#create', on: :member
  end
    
  root :to => 'public#index'
end