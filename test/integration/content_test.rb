require 'test_helper'

class ContentTest < ActionDispatch::IntegrationTest
  test 'noticias e historias se listan públicamente' do
    News.create!(title: 'Noticia pública', summary: 'Resumen', talking: 'Contenido')
    get news_index_path
    assert_response :success
    get stories_path
    assert_response :success
  end

  test 'visitante no crea noticias' do
    sign_in User.create!(email: 'vis-n@ejemplo.com', password: 'secret123')
    assert_no_difference 'News.count' do
      post news_index_path, params: { news: { title: 'X', summary: 'Y', talking: 'Z' } }
    end
    assert_redirected_to root_path
  end

  test 'league admin crea noticias' do
    sign_in User.create!(email: 'liga-n@ejemplo.com', password: 'secret123', role: :league_admin)
    assert_difference 'News.count', 1 do
      post news_index_path, params: { news: { title: 'Nueva noticia', summary: 'Resumen', talking: 'Contenido' } }
    end
  end

  test 'filtro por etiqueta usa el servicio' do
    news = News.create!(title: 'Con tag', summary: 'R', talking: 'C')
    tag = Tags::News.create!(name: 'RugbyNacional')
    Tags::NewsJoin.create!(news: news, tags_news: tag)
    get '/news/tags/RugbyNacional'
    assert_response :success
    assert_select 'a', text: 'Con tag'
  end

  test 'servicio de filtros del home expone 5 modelos' do
    result = Core::Base::FiltersByModel.new.call
    assert_equal 5, result[:objects].count
  end
end
