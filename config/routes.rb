Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
   
  get '/languages', to: 'languages#index'
  get '/current_language', to: 'languages#current_language'
  put '/update_current_language', to: 'languages#update_current_language'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :logo_designs
  
  resources :user_logo
  resources :users
  post '/auth/login', to: 'authentication#login'
  #  get '/*a', to: 'application#not_found'
end
