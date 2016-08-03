Rails.application.routes.draw do
  MongoidReactScaffold::Routing.mount '/', :as => 'mongoid_react_scaffold'
  mount PlayAuth::Engine => '/auth', :as => :auth
  root to: "home#index"
end
