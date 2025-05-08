Rails.application.routes.draw do
  get 'games/play_game'
  get 'games/submit_game'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'hello#index'
  
  get '/hello', to: 'hello#index'

  get '/sign_in', to: 'users#sign_in'
  post '/sign_in', to: 'users#sign_in'

  get '/sign_up', to: 'users#sign_up'
  post '/sign_up', to: 'users#sign_up' 

  get '/user_page', to: 'users#user_page'

  get '/play_game', to: 'games#play_game'
  post '/submit_game', to: 'games#submit_game'
  
  get '/game_history', to: 'game_history#index'
end
