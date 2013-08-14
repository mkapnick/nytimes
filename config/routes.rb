Nytimes::Application.routes.draw do


  resources :tickets

  resources :nytfiles

  resources :offer_chains

  root :to => "offer_chains#index"
  
  /get --> creating an endpoint/ 
  get '/upload', :to => 'upload#index' #:to => '' goes to that controller, specifically, the upload controller 
  match '/upload', :to => 'upload#upload'
  match '/execute', :to => 'upload#execute_python'
  match '/offers.auto.yaml', :to => 'upload#download_yaml_file' 
  match '/offers.auto.sql', :to => 'upload#download_sql_file' 
  match '/inject', :to => 'upload#inject_into_db'
  match '/file.xls', :to => 'upload#download_excel_file'
  match '/svn', :to => 'upload#update_svn_repo'
  match '/jira', :to => 'upload#generate_jira_ticket'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
