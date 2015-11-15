Rails.application.routes.draw do
  get 'relationships/create'

  get 'relationships/destroy'

  get 'about/company_overview'

  get 'users/index'

  get 'users/show'

  devise_for :users, controllers: { 
  sessions: "users/sessions", 
  registrations: "users/registrations", 
  passwords: "users/passwords",
  omniauth_callbacks: "users/omniauth_callbacks" 
}
  resources :users, only:[:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  root to: "top#index"
  resources :blogs
  get 'inquiry', to: 'inquiry#new'
  post 'inquiry/confirm', to: 'inquiry#confirm'
  post 'inquiry/thanks', to: 'inquiry#thanks'
  
  get 'about' => 'about#company_overview'
end
