Amanc::Application.routes.draw do
  root :to => 'splash#index'
  
  match '/play' => 'splash#play', :via => :get
end
