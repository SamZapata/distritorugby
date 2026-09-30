require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  test 'el formulario de inicio de sesion renderiza' do
    get new_user_session_path
    assert_response :success
    assert_select 'form[action=?]', user_session_path
  end

  test 'el formulario de registro renderiza' do
    get new_user_registration_path
    assert_response :success
    assert_select 'form[action=?]', user_registration_path
  end

  test 'el registro crea el usuario y lo autentica' do
    assert_difference 'User.count', 1 do
      post user_registration_path, params: {
        user: {
          email: 'nuevo@ejemplo.com',
          password: 'secret123',
          password_confirmation: 'secret123'
        }
      }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test 'el registro publico no permite asignar un rol privilegiado' do
    post user_registration_path, params: {
      user: {
        email: 'no-admin@ejemplo.com',
        password: 'secret123',
        password_confirmation: 'secret123',
        role: 'super_admin'
      }
    }

    assert_response :redirect
    assert User.find_by!(email: 'no-admin@ejemplo.com').user?
  end

  test 'el inicio de sesion con credenciales validas autentica' do
    user = User.create!(email: 'login@ejemplo.com', password: 'secret123')

    post user_session_path, params: { user: { email: user.email, password: 'secret123' } }

    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test 'el inicio de sesion con password incorrecto no autentica' do
    user = User.create!(email: 'mal@ejemplo.com', password: 'secret123')

    post user_session_path, params: { user: { email: user.email, password: 'incorrecta' } }

    # Devise re-renderiza el formulario en HTML con el error (no usa 401)
    assert_response :success
    assert_nil session['warden.user.user.key']
  end

  test 'la raiz responde con la plantilla de inicio' do
    get root_path
    assert_response :success
  end
end
