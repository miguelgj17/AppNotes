Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/destroy'
  resources :friend_requests
get "logout" => "session#destroy", :as => "logout"
get "login" => "session#new", :as => "login"
post "login" => "session#create"
get "signup" => "users#new", :as => "signup"
resources :users
resources :session
resources :notes
root :to => "session#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
