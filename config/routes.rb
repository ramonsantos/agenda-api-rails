# frozen_string_literal: true

Rails.application.routes.draw do
  api_version(module: 'V1', path: { value: 'v1' }) do
    resources :contacts do
      resource :kind, only: [:show]
      resource :kind, only: [:show], path: 'relationships/kind'

      resource :phones, only: [:show]
      resource :phones, only: [:show], path: 'relationships/phones'

      resource :phone, only: [:update, :create, :destroy]
      resource :phone, only: [:update, :create, :destroy], path: 'relationships/phones'

      resource :address, only: [:show, :update, :create, :destroy]
      resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
    end
  end
end
