Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations]
  as :user do
    # Sensible reroute
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    get 'signup', to: 'devise/registrations#new', as: :new_user_registration
    post 'signup' => 'devise/registrations#create', :as => :user_registration
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session

    # Authenticated users gets a pass to a dedicated /profile
    authenticated :user do
      get 'profile' => 'users/profiles#index', :as => :user_profile
    end
  end
end
