Vibes::Application.routes.draw do
  devise_for :users

  resource :user
  resource :idea
end
