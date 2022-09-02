Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/users" => "users#create"
  
  post "/sessions" => "sessions#create"

  post "/events" => "events#create"

  get "/events" => "events#index"

  post "/event_participants" => "event_participants#create"

  get "/locations" => "locations#index"
end
