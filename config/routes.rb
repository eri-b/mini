Rails.application.routes.draw do

  get 'posts/create'
  get 'posts/delete'
  get  '/:id', to: 'sites#show', as: 'main'
  patch   '/:id',   to: 'sites#update_body', as: 'site_body'
  patch   '/:id',   to: 'sites#update_pass', as: 'site_pass'

  root 'sites#home'

end
