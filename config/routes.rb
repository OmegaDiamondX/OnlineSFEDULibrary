Rails.application.routes.draw do
  root to: 'sfedulib#home', page:1
  get '/:page', to: 'sfedulib#home'
  get '/user/:page', to: 'sfedulib#user'
  post '/search', to: 'sfedulib#update_search_parameters'
  post '/login', to: 'sfedulib#login'
  get '/logout', to: 'sfedulib#logout'
  get '/book/:id', to: 'sfedulib#book_content'
  post '/book/:id', to: 'sfedulib#take_book'
  get '/book/:id/edit', to: 'sfedulib#return_book'
  post '/book/:id/edit', to: 'sfedulib#extend_book'
  post '/book/:id/request', to: 'sfedulib#request_book'
  get '/book/:id/admin', to: 'sfedulib#book_admin'
  post '/book/:id/admin', to: 'sfedulib#book_create'
  post '/book/:id/admin/edit', to: 'sfedulib#book_update'
  get '/book/:id/admin/edit', to: 'sfedulib#book_delete'
end
