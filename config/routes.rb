Rails.application.routes.draw do
  devise_for :users
  # devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :patients do
  	post :import, on: :collection
  	get :export, on: :collection
  end
  root to: 'patients#index'
end
