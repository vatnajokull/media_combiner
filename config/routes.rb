require 'sidekiq/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' # mount Sidekiq::Web in your Rails app

  namespace :v1 do
    resources :users, only: :index
    resource :postcard, only: :show
  end

  namespace :v2 do
    resource :postcard, only: :show
  end

  namespace :v3 do
    resource :postcard, only: :show
  end
end
