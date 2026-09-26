class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Lectura pública: el sitio es de contenido abierto.
    can :read, :all

    return unless user.persisted?

    # Perfil propio. Se compara como texto porque profiles.user_id todavía es
    # string (corrección a bigint pendiente: plan-mvp-f1, paso 1C.3).
    can :manage, Profile, user_id: user.id.to_s

    # Los roles (club_admin, league_admin, super_admin) y los permisos sobre el
    # dominio deportivo se definen en el Lote 3/4 (plan-mvp-f1, fase 1C).
  end
end
