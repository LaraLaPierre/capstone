Rails.application.routes.draw do
  get '/calendar_events' => 'calendar_events#index'
  post '/calendar_events' => 'calendar_events#create'
  get '/calendar_events/:id' => 'calendar_events#show'
  patch '/calendar_events/:id' => 'calendar_events#update'
  delete '/calendar_events/:id' => 'calendar_events#destroy'

  get '/categories' => 'categories#index'
  
end
