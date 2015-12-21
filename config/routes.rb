Rails.application.routes.draw do

  get 'dashboard' => 'dashboard#index'

  devise_for :users

  root to: "home#index"

end
