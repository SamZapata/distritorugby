require 'test_helper'

class Users::ProfilesTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email: 'perfil-propio@ejemplo.com', password: 'secret123')
  end

  test 'requiere login para ver el perfil' do
    get users_profile_path
    assert_redirected_to new_user_session_path
  end

  test 'el usuario ve su propio perfil' do
    sign_in @user

    get users_profile_path

    assert_response :success
    assert_select '.profile-title'
  end

  test 'el usuario abre el formulario de edicion' do
    sign_in @user

    get edit_users_profile_path

    assert_response :success
    assert_select 'form[action=?]', users_profile_path
  end

  test 'el usuario actualiza su propio perfil' do
    sign_in @user

    patch users_profile_path, params: {
      profile: { first_name: 'Juan', last_name: 'Pérez', about: 'Rugbier caleño' }
    }

    assert_redirected_to users_profile_path
    assert_equal 'Juan', @user.profile.reload.first_name
  end

  test 'el perfil rechaza datos invalidos' do
    sign_in @user

    patch users_profile_path, params: {
      profile: { phone_number: 'no-es-telefono-!!!', bithday: 1.day.from_now }
    }

    assert_response :unprocessable_entity
    assert_select '[role="alert"]'
  end

  test 'el perfil no permite asignar rol ni user_id' do
    sign_in @user

    patch users_profile_path, params: {
      profile: { first_name: 'Juana', role: 'super_admin', user_id: 999_999 }
    }

    assert_redirected_to users_profile_path
    assert @user.reload.user?
    assert_equal 'Juana', @user.profile.reload.first_name
  end
end
