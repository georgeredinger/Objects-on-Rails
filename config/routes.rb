ObjectsOnRuby::Application.routes.draw do
  get "blog/index"
  resources :posts
  root :to => "blog#index"
end
