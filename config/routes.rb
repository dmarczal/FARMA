Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :admins, controllers: { sessions: "admin/admins/sessions" }
  namespace :admin do
    get '/' => 'dashboard#index'
  end

  devise_for :users, :controllers => { :registrations => :registrations }
  get 'dashboard' => 'dashboard#index'

  scope :dashboard do
    resources :los do
      resources :introductions , only: [:new, :create, :destroy]
    end
  end


  root to: "home#index"
  resources :contacts, only: [:create]

end
