Rails.application.routes.draw do

  resources :courses
  scope path: '/manager', module: 'manager', as: :manager do
    resources :musics
  end

  scope path: '/kc_courses', module: 'kc_courses', as: :kc_courses do
    resources :wares
  end

  resources :posts
  root to: "posts#index"
  #MongoidReactScaffold::Routing.mount '/', :as => 'mongoid_react_scaffold'
  mount PlayAuth::Engine => '/auth', :as => :auth
  #root to: "home#index"
end
