Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'note#index'
  get '/notes', to: "note#index"
  post '/notes', to: "note#create"
  get '/hashtag/:id', to: "note#hashtag"
  patch '/notes', to: "note#update_note"
  get '/delete', to: "note#destroy"
end
