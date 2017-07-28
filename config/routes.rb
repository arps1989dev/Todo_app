Rails.application.routes.draw do
  devise_for :users, 
   only: :registrations,
    controllers: {
      registrations: 'users/registrations'
    }
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/todos/:importer/callback' => 'todos#contact_callback'
  get "/contacts/:importer/callback" => "todos#index"
  get "/oauth2callback" => "todos#contact"


  resources :todos do
    resources :items
  end
  # post 'auth/login', to: 'authentication#authenticate'
  # post 'signup', to: 'users#create'

  
end
