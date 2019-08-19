Rails.application.routes.draw do

  get  '/:id', to: 'sites#show', as: 'main'
  patch   '/:id',   to: 'sites#add_password', as: 'site_pass'
  patch   '/d/:id',   to: 'sites#remove_password', as: 'd_site_pass'

  resources :posts, only: [:create, :destroy]

  post   '/unlock',   to: 'sessions#create', as: 'unlock'

  root 'sites#home'

end
