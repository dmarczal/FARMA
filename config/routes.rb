Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  #################################### Devise Layout ###########################################

  devise_for :admins, controllers: { sessions: "admin/admins/sessions" }
  devise_for :users, controllers: { registrations: :registrations }

  #################################### Admin Layout ###########################################

  # Routes for admin
  namespace :admin do
    get '/' => 'dashboard#index'
  end

  #################################### Default Layout ###########################################

  # Routes for home
  root to: "home#index"
  resources :contacts, only: :create

  # Routes for los
  resources :los, only: [:index] do
    get '/pages/:page' => 'los#page', as: 'page'
  end

  #################################### Teacher Layout ##########################################

  namespace :teacher do
    get '/' => 'dashboard#index'

    #routes for los (get: index, new, edit, post: create, delete: destroy, put: update)
    resources :los do

      #routes for introductions (get: new, edit, post: create, delete: destroy, put: update)
      resources :introductions , except: :index

      #routes for exercises (get: new, edit, post: create, delete: destroy, put: update)
      resources :exercises , except: :index do

        #routes for questions (get: new, edit, post: create, delete: destroy, put: update)
        resources :questions, except: :index do
          #route for test response
          post '/test-to-answer' => 'questions#test_to_answer'

          #routes for tips (get: new, edit, post: create, delete: destroy, put: update)
          resources :tips, except: :index
        end
      end
    end
  end

end
