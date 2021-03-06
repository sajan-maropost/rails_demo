Rails.application.routes.draw do
  require 'sidekiq/web'

  root 'pages#about_us'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

  get '/about-us', to: 'pages#about_us', as: 'about_us'

  get 'contact-us', to: 'contact_forms#new', as: 'conatct_us'
  post 'contact_forms/create', as: 'create_contact_query'

  get '/gallery', to: 'images#index', as: "gallery"
  get '/gallary/upload', to: 'images#new', as: "new_image"
  post 'images/create', as: "create_image"
  put '/images/update', to: "images#update", as: "update_image"
  post '/images/import', to: 'images#import', as: "import_images"

  get '/image_detail/:id', to: 'images#image_detail', as: 'image_detail'

  get '/images/count', to: 'images#total_count'
  
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  match '*foo', :format => true, :constraints => {:format => :json}, 
    :to => lambda {|env| [404, {}, ['{"error": "page not found", "code": "404"}']] }, via: :all
end
