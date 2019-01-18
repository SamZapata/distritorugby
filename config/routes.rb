Rails.application.routes.draw do
  get 'stories/index'
  get 'news/index'
  get 'toolbox/index'
  get 'tournaments/index'
  get 'histories/index'
  get 'team/index'
  get 'home/index'
  get 'home/aboute'

  # load pdf
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
