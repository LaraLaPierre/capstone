Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/calendar_events' => 'calendar_events#index'

  post '/calendar_events' => 'calendar_events#create'
  # get '/calendar_events/search' => 'calendar_events#search'
  get '/calendar_events/:id' => 'calendar_events#show'
  patch '/calendar_events/:id' => 'calendar_events#update'
  delete '/calendar_events/:id' => 'calendar_events#destroy'

  get '/categories' => 'categories#index'
  
  post "/users" => "users#create"
  post '/user_token' => 'user_token#create'

  get '/wink/authorize' => 'calendar_events#authorize'
  get '/wink/callback' => 'calendar_events#callback'
  get '/wink/tokens' => 'calendar_events#tokens'
  get 'wink/light_bulb' => 'calendar_events#light_bulb'
  get 'wink/turn_on' => 'calendar_events#turn_on'

end
