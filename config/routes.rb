Rails.application.routes.draw do
  # 注文入力・注文作成
  resources :orders, only: [:new, :create] do
    collection do
      get :confirm   #注文確認
    end

    member do
      get :complete  #注文完了
    end
  end

  get 'mypage/show'
  devise_for :admins, controllers: {
    registrations: "admins/registrations",
    sessions: "admins/sessions",
    passwords: "admins/passwords",
    confirmations: "admins/confirmations"
  }

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }

  # 商品登録
  get 'books/new'
  # ユーザ情報の詳細表示
  resources :mypage, only: [:show]
  post 'books', to: 'books#create'
  # 商品一覧
  get 'books', to: 'books#index'
  # 商品詳細
  get 'books/:id', to: 'books#show', as: 'book'
  # 商品編集
  get 'books/:id/edit', to: 'books#edit', as: 'edit_book'
  patch 'books/:id', to: 'books#update'
  # 商品削除
  delete 'books/:id', to: 'books#destroy', as: 'destroy_book'
  root to: "homes#top"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
