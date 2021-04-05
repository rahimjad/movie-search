Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Supply an array of ids as parameters in order to return movie details
  get 'movies',  to: 'movies#show'

  # Supply an array of ids as parameters in order to return actors details
  get 'actors',  to: 'actors#show'

  # This will load the DB records from routes provided for the challenge
  put 'data_load', to: 'data_load#init'
end
