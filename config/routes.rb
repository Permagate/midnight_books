Rails.application.routes.draw do
  get 'books/search'
  get 'books', to: 'books#index'

  root 'books#index'
end
