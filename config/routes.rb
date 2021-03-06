Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations", change_password: "registrations" }

  resources :categories

  resources :plans

  resources :orders

  resources :books do
    collection do
      get :search
    end
    member do
      post :add_to_favorites
      post :remove_favorites
    end
  end

  namespace :admin do
    resources :books do
      member do
        post :publish
        post :hide
      end
      collection do
        get :new_import
        post :create_import
      end
    end
    resources :faqs
    resources :orders
    resources :plans
    resources :users do
      member do
        post :promote
        post :demote
      end
    end
    resources :categories
  end

  namespace :account do
    resources :orders do
      member do
        post :pay_with_alipay
        post :pay_with_wechat
        get :not_valid_subscriber
      end
    end

    resources :users do
      member do
        get :change_password
      end
    end

    resources :favorites
  end

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  get "/how_it_works", to: "welcome#how_it_works"
  get "/about_us", to: "welcome#about_us"
  get "/help_term", to: "welcome#help_term"
  get "/contact_us", to: "welcome#contact_us"

  root to: "welcome#index"
end
