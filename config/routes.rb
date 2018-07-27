Rails.application.routes.draw do
  root to: 'messages#index'

  get ':emoji', to: 'messages#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
