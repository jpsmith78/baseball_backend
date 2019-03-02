Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  #ROUTES FOR PERSON CONTROLLER
  get '/person', to: 'person#index'
  get '/person/:id', to: 'peson#show'
  post '/person', to: 'person#create'
  delete '/person/:id', to: 'person#delete'
  put '/person/:id', to: 'person#update'

  #ROUTES FOR CARD CONTROLLER
  get '/card', to: 'card#index'
  get '/card/:id', to: 'card#show'
  post '/card', to: 'card#create'
  delete '/card/:id', to: 'card#delete'
  put '/card/:id', to: 'card#update'

end
