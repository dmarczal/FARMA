Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: "admin/admins/sessions" }
  namespace :admin do
    get '/' => 'dashboard#index'
  end

  devise_for :users
  get 'dashboard' => 'dashboard#index'

  root to: "home#index"

end
