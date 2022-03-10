Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :tweets do
  member do
    put 'like'
  end
end
  root 'tweets#index'
end
