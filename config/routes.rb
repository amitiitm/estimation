Rails.application.routes.draw do

# You can have the root of your site routed with "root"
  root to: 'dashboards#index'
  resources :login do
    collection do
      post 'sign_up'
      post 'sign_in'
      get 'sign_out'
      get 'forgot_password'
      post 'forgot_password'
    end
  end

  resources :users do
    collection do
      get 'profile'
      get 'activate'
      post 'change_password'
      get 'update_password'
    end
  end

  resources :dashboards
  resources :clients do
    collection do
      get 'register'
      post 'register'
      get 'login'
      post 'login'
      post 'generate_otp'
    end
  end
end
