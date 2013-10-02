Tomatostats::Application.routes.draw do
  authenticated :user do
    root 'pomodoros#index', as: "authenticated_root"
  end

  root to: 'high_voltage/pages#show', id: 'about'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  as :user do
    get 'sign_in' => 'devise/sessions#new', :as => :new_session
    post 'sign_in' => 'devise/sessions#create', :as => :session
    match 'sign_out' => 'devise/sessions#destroy', :as => :destroy_session,
      :via => Devise.mappings[:user].sign_out_via
  end

  resources :pomodoros, only: :index do
    collection do
      post 'delete_multiple_or_assign'
      post 'delete_multiple'
      post 'assign'
    end
  end
  resources :imports, only: [:new, :create]
  resources :projects
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
