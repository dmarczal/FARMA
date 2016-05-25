Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :admins, controllers: { sessions: "admin/admins/sessions" }

  namespace :admin do
    get '/' => 'dashboard#index'
  end

  devise_for :users, :controllers => { :registrations => :registrations }

  root to: "home#index"
  resources :contacts, only: [:create]

  namespace :teacher do
    get '/' => 'dashboard#index'
    resources :los do
      resources :introductions , except: :index

      resources :exercises , except: :index do
        resources :questions, except: :index do
          resources :tips, except: :index
        end
      end
    end
  end

end
