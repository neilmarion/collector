require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admins
  root to: "photos#index"
  mount Sidekiq::Web, at: '/sidekiq'
  mount Collector::API => '/v1'
end
