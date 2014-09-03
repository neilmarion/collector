require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: "admins/sessions" }

  namespace :admin do
    resources :albums do
      resources :advertisements
    end
  end

  root to: "photos#index"
  mount Sidekiq::Web, at: '/sidekiq'
  mount Collector::API => '/v1'
end
