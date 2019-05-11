Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}

  devise_scope :user do
    get '/signout', to: 'devise/sessions#destroy', as: :signout
    get '/signin', to:  'devise/sessions#create' , as: :signin
    get 'signup' , to:  'devise/registrations#new', as: :signup
  end
    
  get 'events/delete' => 'events#destroy'
  get 'rsvp_events/delete' => 'rsvp_events#destroy'
  get 'delete_review' => 'reviews#destroy'
  
  resources :events do  
    collection do 
      get 'past_events' => 'events#past'
      get 'active_events' => 'events#active'
      get 'todays' => 'events#today'
      get 'all_events' => 'events#all'
      get 'top_events' => 'events#top'
      get 'highest_rated' => 'events#highest_rated'
    end
  end
     
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :events

  resources :events do
    resources :reviews
  end
    

  resources :events do
     post '/rsvp_events/create', to: 'rsvp_events#create', on: :member
  end
    
  root :to => 'home#index'
  # get 'sessions/new'
  # get 'sessions/destroy'
  # post 'sessions/create'
  #get '/auth/:provider/callback' => "sessions#create"
    
  #post '/rsvp_events/create', to: 'rsvp_events#create'
end