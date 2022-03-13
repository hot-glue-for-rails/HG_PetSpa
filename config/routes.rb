Rails.application.routes.draw do
  devise_for :human

  root "welcome#index"

  namespace :admin do
    resources :humans do
      resources :pets
    end
    resources :appointments
  end

  namespace :dashboard do
    resources :pets
    resources :appointments
  end
end
