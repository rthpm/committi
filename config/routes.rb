Rails.application.routes.draw do
  resources :homes
  resources :challenges

  root 'homes#index'
  devise_for :users, skip: [:sessions, :registrations]
  as :user do
  
    # Sensible reroute
    get    'login'  => 'devise/sessions#new',         :as => :new_user_session
    post   'login'  => 'devise/sessions#create',      :as => :user_session
    get    'signup' => 'devise/registrations#new',    :as => :new_user_registration
    post   'signup' => 'devise/registrations#create', :as => :user_registration
    delete 'logout' => 'devise/sessions#destroy',     :as => :destroy_user_session

    # Authenticated users gets a pass to a dedicated /profile
    authenticated :user do
      get 'profile' => 'users/profiles#index', :as => :user_profile
    end
  end
end
