Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :sites, only: [:show, :update]
  get  '/:id', to: 'sites#show'
  patch   '/:id',   to: 'sites#update', as: 'site'
  #put   '/:id',   to: 'sites#update', as: 'new_site'

end
