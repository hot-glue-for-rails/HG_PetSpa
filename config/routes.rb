Rails.application.routes.draw do
  devise_for :human

  root "welcome#index"
  namespace :admin do

  end

  namespace :dashboard do
    resources :pets
    resources :appointments
  end
end
