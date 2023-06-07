Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  unauthenticated :user do
    root to: redirect('/login')
  end
  root "uncategorized_pages#mail_template", as: :authenticated_root

  ####
  #### devise
  ####

  devise_scope :user do
    resource :password_changes, path: 'account/settings/password', controller: 'users/password_changes', only: [:edit, :update]
    resource :deactivations, path: 'account/settings/deactivate', controller: 'users/deactivations', only: [:new, :create, :edit, :update]
  end

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'signup',
    password: 'password-flow',
    confirmation: 'confirmation-flow',
    edit: 'account/settings/email/edit',
    cancel: 'cancel-flow',
    unlock: 'unlock-flow'
  }, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  ####
  #### Google SSO
  ####

  scope module: 'users' do
    get 'google_authentication/create', to: 'google_authentications#create', as: :create_google_authentication
  end

  ####
  #### account
  ####

  namespace :account  do
    resource :settings, only: [:edit, :update]
    resource :user_avatars, only: [ :edit, :update, :destroy ]
  end

  ####
  #### uncategorized_pages
  ####

  get '/check-inbox', to: 'uncategorized_pages#check_inbox', as: :check_inbox
  get '/mail-template', to: 'uncategorized_pages#mail_template', as: :mail_template

end
