Rails.application.routes.draw do

  get  '/:id', to: 'sites#show', as: 'main'
  patch   '/:id',   to: 'sites#update_body', as: 'site_body'
  patch   '/:id',   to: 'sites#update_pass', as: 'site_pass'

  resources :posts, only: [:create, :destroy]

  root 'sites#home'

end
