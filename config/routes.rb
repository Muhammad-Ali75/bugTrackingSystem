# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  devise_for :user

  resources :projects
  resources :tickets
end
