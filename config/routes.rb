Rails.application.routes.draw do
  devise_for :user, :path => '', :path_names => { :sign_in => "login",
                                                  :sign_out => "logout",
                                                  :sign_up => "signup", }
  get '/:username' => 'users#show', :as => 'profile'
end
