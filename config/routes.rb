Rails.application.routes.draw do

  namespace :game do
    resources :unions
  end
  namespace :game do
    resources :referees
  end
  namespace :game do
    resources :coaches
  end
  namespace :game do
    resources :players
  end
  namespace :game do
    resources :nn_teams
  end
  namespace :game do
    resources :club_teams
  end
  namespace :game do
    resources :tournaments
  end
  namespace :game do
    resources :match_stats
  end
  namespace :game do
    resources :matches
  end
  namespace :game do
    resources :category_schedules
  end
  namespace :game do
    resources :club_categories
  end
  namespace :game do
    resources :clubs
    get 'clubs/tags/:tag', to: 'clubs#tags'
    get 'clubs/continent/:c', to: 'clubs#continent'
    get 'clubs/:c/union/:u', to: 'clubs#union'
  end
  devise_for :users

  resources :news, controller: 'news' do
    # get 'tags/:tag', to: 'news#tags'
  end
  get 'news/tags/:tag', to: 'news#tags'
  get 'news/:id/tags/:tag', to: 'news#show'

  resources :stories
  get 'stories/tags/:tag', to: 'stories#tags'
  get 'stories/:id/tags/:tag', to: 'stories#show'

  # get 'stories/index'
  get 'toolbox/index'
  # get 'histories/index'
  get 'team/index'
  get 'home/index'
  get 'home/aboute'

  # load pdf
  # mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'

  get 'home/index'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
