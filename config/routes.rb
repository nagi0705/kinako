Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"

  get "/homes/about" => "homes#about", as: "about"
  
  resources :posts  # これによりpostsに対するCRUDルーティングが追加される

  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end  
  
  # ユーザーに対する完全なCRUD操作のルーティングを設定
  resources :users

  # resources :users, only: [:show, :edit, :update] # この行をコメントアウトまたは削除
end
