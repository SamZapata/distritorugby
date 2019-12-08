Rails.application.routes.draw do

  devise_for :users

  get 'stories/index'
  get 'toolbox/index'
  get 'tournaments/index'
  get 'histories/index'
  get 'team/index'
  get 'home/index'
  get 'home/aboute'

  namespace :core do
    resources :news
  end

  # load pdf
  # mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'

  get 'home/index'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
