require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: "admins/sessions" }

  namespace :admin do
    get 'albums/index'
    get 'albums/show'
  end

  namespace :admin do
    resources :albums
  end


  root to: "photos#index"
  mount Sidekiq::Web, at: '/sidekiq'
  mount Collector::API => '/v1'
end
