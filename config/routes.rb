Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :users
    resources :fb_profiles
    get '/extension/download', :to => "extensions#download"
  end

  namespace :api do
    get '/oauth/token', :to => "auth#login"
    get '/oauth/me', :to => "auth#me"
    get '/check_url', :to => "fb_profiles#check_url"
    get '/add_url', :to => "fb_profiles#add_url"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root to: 'admin/fb_profiles#index'

  # Defines the root path route ("/")
  # root "posts#index"
end
