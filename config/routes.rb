Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :recurrings, except: :show do
      resources :plans, except: :show
    end

    resources :subscriptions, only: :index
    resources :subscription_events, only: :index
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :plans, only: [:index]
      resources :subscriptions, only: [:index, :create, :destroy]
    end
  end

  resources :recurring_hooks, only: :none do
    post :handler, on: :collection
  end

  namespace :recurring do
    resources :plans, only: :index do
      resources :subscriptions, only: [:show, :create, :destroy, :new]
    end
  end
end
