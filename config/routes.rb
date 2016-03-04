Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: "admin/admins/sessions" }
  namespace :admin do
    get '/' => 'dashboard#index'
  end

  devise_for :users, :controllers => { :registrations => :registrations }
  get 'dashboard' => 'dashboard#index'

  resources :los, only: [:index, :create, :destroy, :new, :show, :edit, :update]

  root to: "home#index"
  resources :contacts, only: [:create]

end
