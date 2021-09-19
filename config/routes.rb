Rails.application.routes.draw do
  resources :challenges, :path => 'c', :param => :slug, :except => [:index] do
    resources :enrollments, only: [:create, :destroy]
    resources :statuses, :path => 's', :except => [:show, :index] do
      resources :likes, only: [:create, :destroy]
      resources :comments, :except => [:show, :index]
    end
  end

  # Not a typo
  resources :categories, :path => 'challenges', :param => :slug, :only => [:index, :show]

  devise_for :user, :path => '', :path_names => { :sign_in => 'login',
                                                  :sign_out => 'logout',
                                                  :sign_up => 'signup', }

  resource :user, :path => 'a', :only => [:edit, :profile] do
    collection do
      get 'profile'
      patch 'update_profile'
      patch 'update_email_and_password'
    end
  end
  get '/:username' => 'users#show', :as => 'profile'

  authenticated :user do
    root 'users#homepage', as: :authenticated_root
  end
  root 'static#index'

  scope '/premium' do
    get 'info' => 'premium#index', :as => 'premium'
    post 'create' => 'premium#create', :as => 'premium_create'
    get 'success' => 'premium#success', :as => 'premium_success'
    get 'cancel' => 'premium#cancel', :as => 'premium_cancel'
  end
end
