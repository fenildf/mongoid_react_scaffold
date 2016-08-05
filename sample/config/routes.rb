Rails.application.routes.draw do
  resources :posts
  root to: "posts#index"
  #MongoidReactScaffold::Routing.mount '/', :as => 'mongoid_react_scaffold'
  mount PlayAuth::Engine => '/auth', :as => :auth
  #root to: "home#index"
end
