Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/destroy'
  post 'sessions/create'
  get 'events/delete' => 'events#destroy'
  get 'rsvp_events/delete' => 'rsvp_events#destroy'

  #get 'users/new'
  #get 'users/edit'
  #get 'events/new'
  #get 'events/edit'
  #get 'events/index'
  #get 'events/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events do 
    post '/rsvp_events/create', to: 'rsvp_events#create', on: :member
  end 
  
  resources :users
  root :to => 'public#index'
end
