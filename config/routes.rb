Amanc::Application.routes.draw do
  root :to => 'splash#index'
  
   
  match '/play' => 'play#index', :via => :get
  match '/play/next_question' => 'play#next_question', :via => :post
  match '/login' => 'splash#login', :via => :get, :as => 'login'
  match '/logout' => 'splash#logout', :via => :get, :as => 'logout'
  match '/authenticate' => 'splash#authenticate', :via => :post, :as => 'authenticate'
  
 
  
  namespace :admin do
    root :to => 'users#index'
    
    resources :users, :except => [:show]
    resources :players
    resources :topics
    
    
    resources :levels, :only => [:create, :show, :destroy] do 
      resources :questions, :except => [:index]
    end
    
    resources :questions do
      resources :answers, :except => [:index, :show]
    end
    
    
    resources :sponsors do 
      member do 
        get 'edit_logo'
        put 'update_logo'
      end
    
      resources :banners, :only => [:new, :create, :destroy]
    end
  end
end
