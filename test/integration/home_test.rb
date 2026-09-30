require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  test 'home shell con diamond y secciones' do
    get root_path
    assert_response :success
    assert_select '.diamond-container'
    assert_select '.quadrant', count: 4
    assert_select 'a.quadrant-label', text: 'HISTORIAS'
    assert_select 'a.quadrant-label', text: 'CLUBES'
    assert_select '.recommended-title', text: I18n.t('home.recommended.title')
    assert_select '.about-home-title', text: I18n.t('home.about.title')
    assert_select '.community-title', text: I18n.t('home.community.title')
    assert_select '#authModal'
    assert_select '#quadrantModal'
    assert_select '#showMenu a', text: I18n.t('menu.clubs')
  end

  test 'about, team y toolbox responden' do
    get home_about_path
    assert_response :success
    get '/team/index'
    assert_response :success
    get '/toolbox/index'
    assert_response :success
  end
end
