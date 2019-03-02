Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  #ROUTES FOR PERSON CONTROLLER
  get '/person', to: 'person#index'




  #ROUTES FOR CARD CONTROLLER
  get '/card', to: 'card#index'


end
