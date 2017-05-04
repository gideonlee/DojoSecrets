Rails.application.routes.draw do

  get 'likes/create'

  get 'likes/destroy'

  get 'u/new' => 'users#new'

  get 'u/:id' => 'users#show', as: 'users_show'

  post 'u' => 'users#create'

  get 'u/:id/edit' => 'users#edit'

  patch 'u/:id' => 'users#update'

  delete 'u/:id' => 'users#destroy', as: 'users_destroy'

  get 's/new' => 'sessions#new'

  post 's' => 'sessions#login'

  delete 's/:id' => 'sessions#destroy'
  
  get 'secrets' => 'secrets#index'

  post 'secrets' => 'secrets#create'

  delete 'secrets/:id' => 'secrets#destroy'

  post 'likes/:id' => 'likes#create'

  delete 'likes/:id' => 'likes#destroy'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
