Vibes::Application.routes.draw do
  devise_for :users

  resources :users
  resources :ideas do
    get '/upvote' => 'ideas#upvote'
    get '/downvote' => 'ideas#downvote'
  end
end
