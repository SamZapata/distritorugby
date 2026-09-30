require 'test_helper'

class HomeTest < ActionDispatch::IntegrationTest
  test 'home responde con filtros y contenido dinámico' do
    News.create!(title: 'N home', summary: 'R', talking: 'C')
    Game::Tournament.create!(name: 'T home', about: 'D', start_date: Date.today)
    get root_path
    assert_response :success
    assert_select 'a', text: 'Noticias'
    assert_select 'a', text: 'N home'
    assert_select 'a', text: 'T home'
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
