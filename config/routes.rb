Rails.application.routes.draw do

  root to: "projects#index"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :projects do
    resources :bugs
  end
end