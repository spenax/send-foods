Rails.application.routes.draw do
  root to: 'messages#index'

  get '/emoji/:emoji', to: 'messages#show'

  #get '/compare/:emoji', to: 'messages#compare'

  get '/compare', to: 'messages#compare'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
