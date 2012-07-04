Dotfood::Application.routes.draw do

  devise_for :admins

  #match '/restaurants/showAll', :controller => 'restaurants', :action => 'showAll'

  resources :votes

  devise_for :users

  resources :users do
    member do
      get 'change_role'
      get 'add_role'
    end
  end

  resources :votes 

  #match '/restaurants/showAll', :to => 'restaurants#showAll'


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
