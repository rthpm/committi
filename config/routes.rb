Rails.application.routes.draw do
  resources :homes
  resources :challenges, :path => 'c', :param => :slug do
    resources :statuses, :path => 's', :except => [:show, :index] do
      resources :likes, only: [:create, :destroy]
      resources :comments, :except => [:show, :index]
    end
  end

  devise_for :user, :path => '', :path_names => { :sign_in => "login",
                                                  :sign_out => "logout",
                                                  :sign_up => "signup", }

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
  root 'homes#index'
end
