Rails.application.routes.draw do
  resources :posts
  resources :taggings
  resources :tags
end
