Fanfare::Application.routes.draw do

  devise_for :users

  resources :bands

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root 'bands#index'

  namespace :admin do
    resources :users, :only => [:index, :show, :update] do
      member do
        put :edit_points
      end
    end
    resources :products, :except => :show do
      put :toggle_visible, :on => :member
    end
    resources :orders, :only => [:index, :show] do
      put :toggle_sent, :on => :member
    end
    root :to => "users#index"
  end

  resources :orders, :only => [:new, :create] do
    member do
      get :finalize
      get :thanks
      post :thanks
    end
  end

  resources :payments, :only => :none do
    collection do
      post :paypal_ipn
    end
  end

  resources :products, :only => [:index, :show]
  resources :users, :except => [:index, :destroy]

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
