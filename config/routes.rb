Rails.application.routes.draw do

  get  '/:id', to: 'sites#show', as: 'main'
  patch   '/:id',   to: 'sites#update_pass', as: 'site_pass'

  resources :posts, only: [:create, :destroy]

  post   '/unlock',   to: 'sessions#create', as: 'unlock'

  root 'sites#home'

end
