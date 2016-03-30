DatagridDemo::Application.routes.draw do
  root :controller => :home, :action => :index

  resources :users, :only => [:index]
  resources :time_entries, :only => [:index]
  resources :documents, :only => [:index]

  resources :grids, :only => [:index, :create, :show]

end
