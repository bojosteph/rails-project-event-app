Rails.application.routes.draw do

  # get 'reviews/new'
  # get 'reviews/edit'
  # get 'reviews/index'
  # get 'reviews/show'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}

  devise_scope :user do
    get '/signout', to: 'devise/sessions#destroy', as: :signout
    get '/signin', to:  'devise/sessions#create' , as: :signin
    get 'signup' , to:  'devise/registrations#new', as: :signup
  end
  
  # get 'sessions/new'
  # get 'sessions/destroy'
  # post 'sessions/create'
  get 'events/delete' => 'events#destroy'
  get 'rsvp_events/delete' => 'rsvp_events#destroy'
  get 'delete_review' => 'reviews#destroy'
  #get '/auth/:provider/callback' => "sessions#create"
    
  #post '/rsvp_events/create', to: 'rsvp_events#create'
  resources :events do  
    collection do 
      get 'past_events' => 'events#past'
      get 'active_events' => 'events#active'
      get 'todays_events' => 'events#today'
      get 'all_events' => 'events#all'
      get 'top_events' => 'events#top'
    end
  end
  
  resources :events do
    resources :reviews
  end
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do 
    resources :events, only: [:show, :index, :new, :edit, :create, :update]
  end 

  resources :events do
     post '/rsvp_events/create', to: 'rsvp_events#create', on: :member
  end
    
  root :to => 'home#index'
end