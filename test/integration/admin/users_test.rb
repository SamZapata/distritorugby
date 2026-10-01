require 'test_helper'

class Admin::UsersTest < ActionDispatch::IntegrationTest
  setup do
    @super_admin = User.create!(email: 'super-roles@ejemplo.com', password: 'secret123', role: :super_admin)
    @regular = User.create!(email: 'regular-roles@ejemplo.com', password: 'secret123')
  end

  test 'requiere login para listar usuarios' do
    get admin_users_path
    assert_redirected_to new_user_session_path
  end

  test 'super admin lista usuarios' do
    sign_in @super_admin

    get admin_users_path

    assert_response :success
    assert_select 'h1', text: 'Usuarios'
    assert_select 'td', text: @regular.email
  end

  test 'usuario regular no puede listar usuarios' do
    sign_in @regular

    get admin_users_path

    assert_redirected_to root_path
  end

  test 'club admin no puede listar usuarios' do
    club_admin = User.create!(email: 'club-roles@ejemplo.com', password: 'secret123', role: :club_admin)
    sign_in club_admin

    get admin_users_path

    assert_redirected_to root_path
  end

  test 'super admin abre edicion y asigna rol' do
    sign_in @super_admin

    get edit_admin_user_path(@regular)
    assert_response :success
    assert_select 'select[name="user[role]"]'

    patch admin_user_path(@regular), params: { user: { role: 'club_admin' } }

    assert_redirected_to admin_users_path
    assert @regular.reload.club_admin?
  end

  test 'super admin no puede quitarse su propio rol' do
    sign_in @super_admin

    patch admin_user_path(@super_admin), params: { user: { role: 'user' } }

    assert_redirected_to edit_admin_user_path(@super_admin)
    assert @super_admin.reload.super_admin?
  end

  test 'super admin no puede degradar al ultimo super_admin' do
    only_admin = User.create!(email: 'unico-admin@ejemplo.com', password: 'secret123', role: :super_admin)
    User.where.not(id: only_admin.id).update_all(role: User.roles[:user])
    sign_in only_admin
    target = User.where.not(id: only_admin.id).first

    patch admin_user_path(target), params: { user: { role: 'user' } }
    # degradar a otro no-super_admin esta permitido; el bloqueo aplica al ultimo super_admin
    assert_redirected_to admin_users_path

    patch admin_user_path(only_admin), params: { user: { role: 'user' } }
    assert_redirected_to edit_admin_user_path(only_admin)
    assert only_admin.reload.super_admin?
  end

  test 'usuario regular no puede escalar su rol' do
    sign_in @regular

    patch admin_user_path(@regular), params: { user: { role: 'super_admin' } }

    assert_redirected_to root_path
    assert @regular.reload.user?
  end
end
