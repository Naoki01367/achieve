Rails.application.routes.draw do
root to: "top#index"
  resources :blogs
  get 'forms', to: 'forms#index' 
end
