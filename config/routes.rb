Rails.application.routes.draw do

  resources :stories
  devise_for :users
  
  # get 'stories/index'
  get 'toolbox/index'
  get 'tournaments/index'
  # get 'histories/index'
  get 'team/index'
  get 'home/index'
  get 'home/aboute'

  resources :news

  # load pdf
  # mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'

  get 'home/index'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
