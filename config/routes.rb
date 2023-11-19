Rails.application.routes.draw do
  # For unknown reasons, all atempts at creating a controller fail, help.
  root 'SFEDUlib#home'
  get '\home', to: 'SFEDUlib#home'
  post '\login', to: 'SFEDUlib#login'
  get '\logout', to: 'SFEDUlib#logout'
  get '\:id', to: 'SFEDUlib#book'
  post '\:id', to: 'SFEDUlib#take_book'
  delete '\:id', to: 'SFEDUlib#return_book'
  patch '\:id', to: 'SFEDUlib#extend_book'
  post '\:id\request', to: 'SFEDUlib#request_book'
  get '\:id\:page', to: 'SFEDUlib#open_book'
end
