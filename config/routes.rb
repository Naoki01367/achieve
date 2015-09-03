Rails.application.routes.draw do
  root to: "top#index"
  resources :blogs
  get 'inquiry', to: 'inquiry#index'
  post 'inquiry/confirm', to: 'inquiry#confirm'
  post 'inquiry/thanks', to: 'inquiry#thanks'
end
