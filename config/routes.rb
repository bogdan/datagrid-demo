DatagridDemo::Application.routes.draw do
  resources :user_reports, :only => [:index]
  root :controller => :home, :action => :index
end
