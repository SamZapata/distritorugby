require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test 'requiere usuario' do
    profile = Profile.new(first_name: 'Sin', last_name: 'Usuario')
    assert_not profile.valid?
    assert_includes profile.errors[:user], 'debe existir'
  end

  test 'es valido con usuario' do
    user = User.create!(email: 'perfil2@ejemplo.com', password: 'secret123')
    profile = Profile.new(user: user, first_name: 'Juan', last_name: 'Perez')
    assert profile.valid?
  end

  test 'rechaza telefono con formato invalido' do
    user = User.create!(email: 'tel@ejemplo.com', password: 'secret123')
    profile = Profile.new(user: user, phone_number: 'no-es-telefono-!!!')
    assert_not profile.valid?
    assert_includes profile.errors[:phone_number], 'no es válido'
  end

  test 'rechaza fecha de nacimiento futura' do
    user = User.create!(email: 'fecha@ejemplo.com', password: 'secret123')
    profile = Profile.new(user: user, bithday: 1.day.from_now)
    assert_not profile.valid?
    assert_includes profile.errors[:bithday], 'no puede estar en el futuro'
  end
end
