Vibes::Application.routes.draw do
  root 'users#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations' }

  resources :users
  resources :ideas do
    get '/upvote' => 'ideas#upvote'
    get '/downvote' => 'ideas#downvote'
  end

  resources :comments, only: :create
end
