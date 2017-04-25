Rails.application.routes.draw do

  # API Routes
  namespace :api do
    resources :first_advantage, only: [] do
      collection do
        post :candidate_invitation_status_callback, defaults: { format: :xml }
      end
    end
    resources :user
    resources :payment
    resources :subscription
  end

  # Encrypt
  get '/.well-known/acme-challenge/:id', to: 'public#letsencrypt'

  # Root
  root to: 'public#index'

  # Store
  # get 'online-store', to: 'store#index', as: :store
  # get 'online-store/categories', to: 'store#categories', as: :store_categories
  # get 'online-store/categories/:permalink', to: 'store#category_handler', as: :store_category
  # get 'online-store/categories/:category_permalink/items', to: 'store#products', as: :store_category_products
  # get 'online-store/categories/:category_permalink/:permalink', to: 'store#product_handler', as: :store_category_product

  # Demo
  get 'demo', to: 'public#splash'

  # Send Pre-Register Form
  post 'mailer/send-contact-form', to: 'public#send_contact', as: :send_form

  # Temp
  get 'admin', to: 'public#manage_content', as: :manage_content
  put 'update-splah-page', to: 'public#update_content', as: :update_content

  # Devise
  devise_for :admins,
             path: 'admin',
             controllers: {
               registrations: "devise/admins/registrations",
               sessions: "devise/admins/sessions",
               passwords: "devise/admins/passwords",
               unlocks: "devise/admins/unlocks",
               confirmations: 'devise/admins/confirmations'
             }

  # Custom Auth
  # scope :auth do
  #   resources :sessions, only: [:new, :create, :destroy]
  # end
  # Test Auth
  get 'locked', to: 'public#locked', as: :locked

  # Api
  namespace :api do
    resources :payments, except: [:delete] do
      get :mobile_form, path: 'mobile-form', on: :collection
      post :create_from_mobile_form, on: :collection
    end
  end

  # CMS
  scope :cms do
    resources :facts, :videos, :testimonials
    resources :pages do
      resources :sections
    end
    # resources :categories do
    #   resources :products
    # end
  end

end
