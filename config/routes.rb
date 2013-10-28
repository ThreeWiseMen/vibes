Vibes::Application.routes.draw do
  devise_for :users

  resources :users
  resources :ideas
end
