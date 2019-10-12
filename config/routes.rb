Rails.application.routes.draw do
  namespace :api do
    post '/questions/:id/test_answer' => 'questions#test_answer'
    post '/questions/:id/reset_tries' => 'questions#reset_tries'

    scope '/team/:team_id/exercise/:exercise_id' do
      post '/questions/:id/create_answer' => 'questions#create_answer'
      get '/load_student_questions' => 'questions#load_student_questions'
    end

    scope '/exercises/:exercise_id' do
      resources :questions, except: [:new, :edit] do
        resources :tips, except: [:new, :edit]
      end
    end

    resources :gallery, only: :create
  end

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
