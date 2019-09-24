Rails.application.routes.draw do

  get  '/:id', to: 'sites#show', as: 'main', constraints: { id: /[^\/]+/ }
  patch   '/:id',   to: 'sites#add_password', as: 'site_pass'
  patch   '/d/:id',   to: 'sites#remove_password', as: 'd_site_pass'

  resources :posts, only: [:create, :destroy]

  post   '/unlock',   to: 'sessions#create', as: 'unlock'
  delete '/logout/:id',  to: 'sessions#destroy', as: 'logout'

  root 'sites#home'

end
