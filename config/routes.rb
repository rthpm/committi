Rails.application.routes.draw do
  resources :homes
  resources :challenges, :path => 'c', :param => :slug do
    resources :statuses, :path => 's', :except => [:show] do
      resources :likes, only: [:create, :destroy]
    end
  end

  root 'homes#index'

  devise_for :user, :path => '', :path_names => { :sign_in => "login",
                                                  :sign_out => "logout",
                                                  :sign_up => "signup", }
  get '/:username' => 'users#show', :as => 'profile'
end
