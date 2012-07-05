Dotfood::Application.routes.draw do

  devise_for :admins

  devise_for :users

  resources :users do
    member do
      get 'change_role'
      get 'add_role'
    end
  end

  resources :votes 

  resources :restaurants do
    member do
      get 'upvote'
      get 'downvote'
    end
    collection do
      get 'dashboard'
      get 'index'
    end
  end
  
  root :to => "restaurants#dashboard"
 
end
