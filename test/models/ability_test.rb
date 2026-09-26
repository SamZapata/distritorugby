require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  test 'el invitado puede leer contenido publico' do
    ability = Ability.new(nil)
    assert ability.can?(:read, News)
    assert ability.can?(:read, Story)
    assert ability.can?(:read, User)
  end

  test 'el invitado no puede gestionar su perfil' do
    ability = Ability.new(nil)
    profile = Profile.new(user_id: '1')
    assert_not ability.can?(:manage, profile)
  end

  test 'el usuario autenticado gestiona su propio perfil' do
    user = User.create!(email: 'ability@ejemplo.com', password: 'secret123')
    ability = Ability.new(user)
    profile = Profile.new(user_id: user.id)
    assert ability.can?(:manage, profile)
  end

  test 'el usuario autenticado no gestiona el perfil de otro' do
    user = User.create!(email: 'otro@ejemplo.com', password: 'secret123')
    ability = Ability.new(user)
    perfil_ajeno = Profile.new(user_id: (user.id + 1).to_s)
    assert_not ability.can?(:manage, perfil_ajeno)
  end

  test 'el usuario autenticado puede leer contenido publico' do
    user = User.create!(email: 'lector@ejemplo.com', password: 'secret123')
    ability = Ability.new(user)
    assert ability.can?(:read, News)
    assert ability.can?(:read, Story)
  end
end
