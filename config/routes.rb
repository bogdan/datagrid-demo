DatagridDemo::Application.routes.draw do
  root :controller => :home, :action => :index

  resources :user_reports, :only => [:index]
  resources :time_entry_reports, :only => [:index]

end
