Vibes::Application.routes.draw do
  root 'ideas#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations' }

  resources :users
  resources :ideas do
    get '/upvote' => 'ideas#upvote'
    get '/downvote' => 'ideas#downvote'
  end

  resources :comments, only: :create

  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :ideas, only: [:index, :show] do
        get '/upvote' => 'ideas#upvote'
        get '/downvote' => 'ideas#downvote'
        get '/vote_for_current_user' => 'ideas#vote_for_current_user'
      end

      get '/users/current' => 'users#current'
    end
  end
end
