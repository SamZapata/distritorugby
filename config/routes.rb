Rails.application.routes.draw do
  # Health check para despliegues y monitores
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Las rutas de negocio se agregan a partir del Lote 3.
  # root 'home#index'
end
