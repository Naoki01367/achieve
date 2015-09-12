Rails.application.routes.draw do
  devise_for :users
  root to: "top#index"
  resources :blogs
  get 'inquiry', to: 'inquiry#new'
  post 'inquiry/confirm', to: 'inquiry#confirm'
  post 'inquiry/thanks', to: 'inquiry#thanks'
end
