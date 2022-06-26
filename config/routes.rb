Rails.application.routes.draw do
  resources :tags
  resources :books
  resources :rakutenbooks, only: [:new, :index]
  
  
  get 'search' => 'books#search'
  get 'loading' => 'tags#loading'

  # modalで削除確認画面実装(book)
  get 'books/:id/deletemodal' => 'books#deletemodal', as: 'deletemodal'
  # modalで削除確認画面実装(tag)
  get 'tags/:id/deletemodal' => 'tags#tagdeletemodal', as: 'tagdeletemodal'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "home#index"
end
