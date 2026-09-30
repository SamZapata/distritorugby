Rails.application.routes.draw do
  # Health check para despliegues y monitores
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Autenticación (Lote 2)
  devise_for :users

  resources :news, controller: 'news'
  get 'news/tags/:tag', to: 'news#tags', as: :news_tags

  resources :stories
  get 'stories/tags/:tag', to: 'stories#tags', as: :stories_tags

  namespace :game do
    resources :unions
    resources :nn_teams
    resources :players
    resources :tournaments do
      resources :groups, controller: 'tournament/groups' do
        resources :group_assignments, only: %i[create destroy], controller: 'group_matches'
      end
    end
    resources :matches do
      resource :stat, only: %i[show new create edit update], controller: 'match_stats'
      resources :club_assignments, only: %i[create destroy], controller: 'club_matches'
    end
    resources :coaches
    resources :referees, controller: 'referees'
    resources :clubs do
      resources :admin_assignments, only: %i[create destroy], controller: 'admin_assignments'
      resources :coach_assignments, only: %i[create destroy], controller: 'club_coach_joins'
      resources :categories, controller: 'club_categories' do
        resources :schedules, controller: 'category_schedules'
        resources :teams, controller: 'club_teams' do
          resources :player_assignments, only: %i[create destroy], controller: 'player_cteam_joins'
          resources :coach_assignments, only: %i[create destroy], controller: 'coach_team_joins'
        end
        resources :player_assignments, only: %i[create destroy], controller: 'player_category_joins'
      end
    end
  end

  # Raíz mínima: Devise redirige aquí tras login y CanCan en denegaciones.
  # El home real (secciones diamond, etc.) se migra en el Lote 4.
  root 'home#index'
end
