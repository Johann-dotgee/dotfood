Dotfood::Application.routes.draw do

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :groups do
    resources :events do 
      resources :sondages do
        get 'add_restaurant'
      end
    end
  end


  devise_for :admins

  devise_for :users

  resources :users do
    resources :groups
    member do
      get 'change_role'
      get 'add_role'
      get 'eat_alone'
    end
  end

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  resources :votes 

  resources :restaurants do
    resources :ratings
    resources :comments do
      member do
        post 'like'
      end
    end
    member do
      post 'upvote'
      post 'downvote'
      post 'vote2'
      post 'rate'
      # match "upvote/:number" => "restaurants#upvote"
      # match "downvote/:number" => "restaurants#downvote"
    end
    collection do
      get 'dashboard'
      get 'index'
    end
  end
  
  root :to => "restaurants#dashboard"
 
end
