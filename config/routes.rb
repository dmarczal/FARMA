Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  #################################### Devise Layout ###########################################

  devise_for :admins, controllers: { sessions: "admin/admins/sessions" }
  devise_for :users, controllers: { registrations: :registrations }

  devise_scope :user do
    get '/workspace' => 'workspace#choose'
  end

  #################################### Admin Layout ###########################################

  # Routes for admin
  namespace :admin do
    get '/' => 'dashboard#index'
    resources :researches
    resources :developers
  end

  #################################### Default Layout ###########################################

  # Routes for home
  root to: "home#index"
  resources :contacts, only: :create
  get '/team' => 'team#index'

  # Routes for los
  resources :los, only: [:index]

  #################################### Teacher Layout ##########################################

  namespace :teacher do
    get '/' => 'dashboard#index'

    #routes for teams (get: [index, new, show], post: create)
    resources :teams, except: [:edit, :update]

    #routes for los (get: [index, new, edit], post: create, delete: destroy, put: update)
    resources :los do

      #routes for introductions (get: [new, edit], post: create, delete: destroy, put: update)
      resources :introductions , except: :index

      #routes for exercises (get: [new, edit], post: create, delete: destroy, put: update)
      resources :exercises , except: :index do

        #routes for questions (get: [new, edit], post: create, delete: destroy, put: update)
        resources :questions, except: :index do
          #route for test response
          post '/test-to-answer' => 'questions#test_to_answer'

          #routes for tips (get: [new, edit], post: create, delete: destroy, put: update)
          resources :tips, except: :index
        end
      end
    end
  end

  #################################### Student Layout ##########################################

  namespace :student do
    get '/' => 'dashboard#index'

    #routes for teams (get: [index, new], post: create)
    resources :teams, only: [:index, :show, :create] do

      get '/los/:id/page/:page' => 'los#show', as: :lo
    end

    get '/find_teams' => 'teams#find_teams'
    get '/registered-teams' => 'teams#registered'
  end
end
