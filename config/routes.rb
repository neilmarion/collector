require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :admin do
  get 'photos/update_show'
  end

  devise_for :admins, controllers: { sessions: "admins/sessions" }

  namespace :admin do
    resources :albums do
      resources :advertisements
    end

    resources :photos do
      member do
        post :update_show
      end
    end
  end

  root to: "photos#index"
  mount Sidekiq::Web, at: '/sidekiq'
  mount Collector::API => '/v1'
end
