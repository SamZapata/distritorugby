Rails.application.routes.draw do
  # Health check para despliegues y monitores
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Autenticación (Lote 2)
  devise_for :users

  namespace :game do
    resources :unions
    resources :clubs do
      resources :admin_assignments, only: %i[create destroy], controller: 'admin_assignments'
      resources :categories, controller: 'club_categories' do
        resources :schedules, controller: 'category_schedules'
      end
    end
  end

  # Raíz mínima: Devise redirige aquí tras login y CanCan en denegaciones.
  # El home real (secciones diamond, etc.) se migra en el Lote 4.
  root 'home#index'
end
