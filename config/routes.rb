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

  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :ideas, only: [] do
        get '/upvote' => 'ideas#upvote'
        get '/downvote' => 'ideas#downvote'
      end
    end
  end
end
