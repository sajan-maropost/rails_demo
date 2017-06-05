Rails.application.routes.draw do
  devise_for :users
  root 'pages#about_us'
  get '/about-us', to: 'pages#about_us'
end
