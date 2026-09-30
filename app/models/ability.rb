class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Lectura pública: el sitio es de contenido abierto.
    can :read, :all
    cannot :read, Game::ClubAdminAssignment

    return unless user.persisted?

    can :manage, Profile, user_id: user.id

    if user.super_admin?
      can :manage, :all
    elsif user.club_admin?
      # Step 0.1: club_admin solo update de clubes asignados vía
      # game_club_admin_assignments. Sin create/destroy, sin cambio de
      # union (filtrado en ClubsController#club_params), sin auto-asignar.
      can :update, Game::Club, id: user.managed_club_ids
      # Lote 4.1: gestión de categorías y horarios solo en clubes asignados.
      can :manage, Game::ClubCategory, club_id: user.managed_club_ids
      can :manage, Game::CategorySchedule, club_category: { club_id: user.managed_club_ids }
      # Lote 4.2: equipos y plantillas solo en clubes asignados; jugadores
      # lectura pública, creación/edición para staff, borrado super_admin.
      can :manage, Game::ClubTeam, club_id: user.managed_club_ids
      can :create, Game::Player
      can :update, Game::Player
      can :manage, Game::PlayerCteamJoin, club_team: { club_id: user.managed_club_ids }
      can :manage, Game::PlayerCategoryJoin, club_category: { club_id: user.managed_club_ids }
    end
    # Step 0.2: league_admin sin privilegios extra hasta Lote 4.3
    # (solo lectura pública + perfil propio).
    # Step 0.4: sin UI de gestión de roles en Lote 3; roles solo por
    # consola/semilla. El registro público no permite escalamiento
    # (sin role en strong params de Devise).
  end
end
