Rails.application.routes.draw do
  extend BeOneAdmin::RoutableConcern

  require 'sidekiq/web'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.application.secrets[:sidekiq_web][:username])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.application.secrets[:sidekiq_web][:password]))
  end if Rails.env.production?

  mount Sidekiq::Web, at: "/jobs"
  mount BeOneAdmin::Engine, at: "/#{BeOneAdmin.config.route}", as: :admin_root
  mount ActionCable.server => '/cable'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  get :"benefits/for_buyer", to: "main#for_buyer"
  get :"benefits/for_seller", to: "main#for_seller"
  
  post :"webhooks/whatsapp", to: "webhooks#whatsapp"

  scope "(:market)", market: /#{AVAILABLE_MARKETPLACES.join("|")}/ do
    resources :bids
    resources :members
    resources :quick_offers, only: %i[create]
    resources :alerts
    resources :offers, concerns: [:attach_concern] do
      member do
        post :bid
        post :to_top
        post :inquiry
        get :full
        post :delete_image
      end
      collection do
        get :list
        get :my
        post :send_to_promote
        get :for_promote
      end
    end
    resources :requests do
      member do
        post :bid
        post :inquiry
        post :send_offers
        post :to_top
      end
      collection do
        get :list
      end
    end
    resources :companies, only:[:index,:show,:edit,:update] do
      member do
        get :chart
        get :info
        get :rating
        get :contacts
        post :document
        get :products
        get :requests
        get :offers
      end
    end
    get 'marketplace/offers/category/:seo', to: "categories#show"
    get 'marketplace/offers/:id', to: "offers#show"
    get 'marketplace/requests/:id', to: "requests#show"

    get 'marketplace/offers/:seo/:id', to: "offers#show"
    get 'marketplace/requests/:seo/:id', to: "requests#show"

    resources :conversations do 
      member do 
        post :inquiry
      end
    end
    resources :proceses do
      member do
        get :start
        post :sign
        get :download
        post :upload
        post :cancel
        post :complain
        post :complete_step, path: "complete_step/:step"
        post :add_file
        get :show_step, path: "show_step/:step"
      end
    end
    resources :notifications, only:[:index,:show]
    resources :invoices#, only:[:index,:create,:destroy]
    resources :transactions, only:[:index,:show, :create] do
      member do
        get :cancelled
        get :success
      end
    end

    
    resources :articles, only:[:index,:show]
    resources :faqs, only:[:index,:show]

  end
  root 'main#landing'
  get :marketplace, to: "main#index"
  scope "(:market)", market: /#{AVAILABLE_MARKETPLACES.join("|")}/ do
    scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

      # root 'main#landing'


      post :subscribe, to: "main#subscribe"
      post :subscribe_from_pricing, to: "main#subscribe_from_pricing"
      post :subscribe_from_benefit, to: "main#subscribe_from_benefit"

      get 'restore/:token' => 'sessions#restore', as: 'restore'
      post 'restore/:token' => 'sessions#restore', as: 'change_password'
      get 'verify/:code' => 'sessions#verify', as: 'verify'
      get 'resend' => 'sessions#resend', as: 'resend'


      get "country/:country_code/:marketplace_type", to: "main#seo_page", as: 'country_seo_page'
      get "category/:category_seo/:marketplace_type", to: "main#seo_page", as: 'category_seo_page'
      get "category/:country_code/:category_seo/:marketplace_type", to: "main#seo_page", as: 'country_category_seo_page'

      post :log, to: "main#log"
      post :contact, to: "main#contact"
      post :feedback, to: "main#feedback"

      get :faq, to: "main#faq"
      # get :marketplace, to: "main#index"
      get "/marketplace/marketplace", to: "main#index"

      get :thank_you, to: "main#index"

      get "/email/registration", to: "email#registration"
      get "/email/change_password", to: "email#change_password"
      get "/email/remind_password", to: "email#remind_password"
      get "/email/notification", to: "email#notification"
      get "/email/verify", to: "email#verify"
      get "/email/subscription", to: "email#subscription"

      get :pricing, to: "main#pricing"
      get :about, to: "main#about"
      get :how_it_works, to: "main#how_it_works"
      get :config, to: "main#marketplace"
      get :full_config, to: "main#full_config"

      get :user_chart, to: "members#chart"
      get :new_messages_count, to: "members#new_messages_count"


      get "/page/:id", to: "articles#page"

      # post :telegram_vbc43edbf1614a075954dvd4bfab34l5, to: "telegram#start"


      #telegram_webhook TelegramController


      get "/services/verification"
      get "/services/safe_deal"

      post "service", to: "services#create", as:"service"

      %w(categories login restore_password inq_restore_password).each do |route|
        get route, to: "main##{route}"
      end

      %w(sign_in sign_up remind resend reg_inq).each do |route|
        post route, to: "sessions##{route}"
      end

      %w(logout).each do |route|
        get route, to: "sessions##{route}"
      end
    end
  end

  %w( 404 422 500 503 ).each do |code|
    get code, to: "main#error", code: code
  end

  namespace :admin do
    post "uploads/images", to: "uploads#images"

    namespace :content do
      resources :email_templates
      resources :faqs
      resources :posts
      resources :pages
      resources :seo_pages do
        post :generate_missing, on: :collection
      end
    end

    namespace :traffic do
      resources :sources
    end


    namespace :delivery do
      resources :conditions, concerns: :has_many_concern
      resources :packages
      resources :payment_types
      resources :steps, concerns: :habtm_concern
      resources :step_fields, concerns: :habtm_concern
    end

    namespace :order do
      resources :items
      resources :services, concerns: :has_many_concern
      resources :payment_transactions
      resources :carts
      resources :service_categories, concerns: [:has_many_concern] do 
        member do
          post :up
          post :down
        end
      end
      resources :service_items do 
        member do
          post :up
          post :down
        end
      end 

      resources :packages, concerns: [:attach_concern] do 
        member do
          post :up
          post :down
        end
      end
    end

    namespace :geo do
      resources :countries
      resources :regions
      resources :ports
      resources :sea_lines
    end

    namespace :meat do
      resources :offers
      resources :quick_offers
      resources :certificates
      resources :documents
      resources :requests
      resources :bids
      resources :promotions
      resources :companies do
        collection do
          get :export
        end
        member do
          post :delete_passport
          post :delete_bill
        end
      end
      resources :categories do 
        member do
          post :up
          post :down
        end
      end
      resources :company_users do
        member do
          post :otp
          post :go_to_company
        end
      end
      resources :invoices do
        member do
          post :decline
          post :approve
        end
      end
    end

    namespace :chat do
      resources :inquiries do 
        post :send_mail, on: :member
        post :toogle_request, on: :member
      end
      resources :conversations, concerns: :has_many_concern
      resources :notifications
      resources :messages
      resources :contacts
      resources :feedbacks
      resources :subscribers do
        collection do
          get :export
        end
      end
    end
  end
  scope "(:market)", market: /#{AVAILABLE_MARKETPLACES.join("|")}/ do
    get '*all', to: 'main#index', constraints: lambda { |req|
      req.path.exclude?('files/representations') && req.path.exclude?('files/blobs')
    }
  end

end
