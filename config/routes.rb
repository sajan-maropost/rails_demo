Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'pages#about_us'
  get '/about-us', to: 'pages#about_us', as: 'about_us'

  get 'contact_forms/new', as: 'conatct_us'
  post 'contact_forms/create', as: 'create_contact_query'
end
