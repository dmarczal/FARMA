Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  #################################### Devise Layout ###########################################

  devise_for :admins, controllers: { sessions: "admin/admins/sessions" }
  devise_for :users, controllers: { registrations: :registrations }

  devise_scope :user do
    get '/choose_workspace' => 'dashboard#choose_workspace'
  end

  #################################### Admin Layout ###########################################

  # Routes for admin
  namespace :admin do
    get '/' => 'dashboard#index'
    resources :researches
  end

  #################################### Default Layout ###########################################

  # Routes for home
  root to: "home#index"
  resources :contacts, only: :create

  # Routes for los
  resources :los, only: [:index]

  #################################### Teacher Layout ##########################################

  namespace :teacher do
    get '/' => 'dashboard#index'

    #routes for teams (get: [index, new, show], post: create)
    resources :teams, only: [:index, :new, :create, :show] do
      get '/add-los' => 'teams#list_add_los'
      post '/add-los' => 'teams#add_los'

      get '/los/:id' => 'teams#lo', as: :lo
    end

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
    resources :teams, only: [:index, :show, :create]

    get '/registered-teams' => 'teams#registered'

    resources :los
  end

  #################################### view lo Layout ###########################################

  namespace :view_lo do
    get 'teams/:team_id/los/:lo_id/pages/:page' => 'los#page', as: 'page'

    post 'teams/:team_id/los/:lo_id/exercises/:exercise_id/questions/:question_id/create' => 'answers#create', as: 'answer'

    get 'team/:team_id/questions/:question_id/tips/:id' => 'tips#show', as: 'tip'
  end

end
