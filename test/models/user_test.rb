require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'es valido con email y password validos' do
    user = User.new(email: 'rugby@ejemplo.com', password: 'secret123')
    assert user.valid?
  end

  test 'requiere email' do
    user = User.new(password: 'secret123')
    assert_not user.valid?
    assert_includes user.errors[:email], "no puede estar en blanco"
  end

  test 'rechaza email duplicado' do
    User.create!(email: 'dup@ejemplo.com', password: 'secret123')
    duplicado = User.new(email: 'dup@ejemplo.com', password: 'secret123')
    assert_not duplicado.valid?
    assert_includes duplicado.errors[:email], 'ya está en uso'
  end

  test 'requiere password de al menos 6 caracteres' do
    user = User.new(email: 'corto@ejemplo.com', password: 'abc')
    assert_not user.valid?
    assert_includes user.errors[:password], 'es demasiado corto (6 caracteres mínimo)'
  end

  test 'crea un perfil al crear el usuario' do
    user = User.create!(email: 'perfil@ejemplo.com', password: 'secret123')
    assert_instance_of Profile, user.profile
    assert_equal user.id, user.profile.user_id
  end

  test 'el rol predeterminado es user' do
    user = User.create!(email: 'rol@ejemplo.com', password: 'secret123')
    assert user.user?
  end

  test 'guarda la password hasheada y no en texto plano' do
    user = User.create!(email: 'hash@ejemplo.com', password: 'secret123')
    assert_not_equal 'secret123', user.encrypted_password
    assert user.encrypted_password.present?
    assert user.valid_password?('secret123')
  end
end
