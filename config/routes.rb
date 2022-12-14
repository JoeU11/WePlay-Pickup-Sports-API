Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/users" => "users#create"
  
  post "/sessions" => "sessions#create"

  post "/events" => "events#create"

  get "/events" => "events#index"

  get "/events/:id" => "events#show"

  patch "events/:id" => "events#update"

  delete "/events/:id" => "events#destroy"

  post "/event_participants" => "event_participants#create"

  get "/locations" => "locations#index"

  post "/locations" => "locations#create"

  get "/event_participants" => "event_participants#index"
  
  delete "/event_participants/:id" => "event_participants#destroy"

# testing OAuth
  get "/oauth" => "events#test_get_oauth"
  post "/oauth" => "events#test_post_oauth"
end
