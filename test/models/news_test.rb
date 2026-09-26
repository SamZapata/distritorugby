require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  def noticias_validas
    { title: 'Noticia unica', summary: 'Resumen', talking: 'Cuerpo' }
  end

  test 'es valida con los atributos requeridos' do
    assert News.new(noticias_validas).valid?
  end

  test 'requiere title, summary y talking' do
    noticia = News.new
    assert_not noticia.valid?
    assert_includes noticia.errors[:title], 'no puede estar en blanco'
    assert_includes noticia.errors[:summary], 'no puede estar en blanco'
    assert_includes noticia.errors[:talking], 'no puede estar en blanco'
  end

  test 'requiere title unico' do
    News.create!(noticias_validas)
    duplicada = News.new(noticias_validas.merge(title: 'Noticia unica'))
    assert_not duplicada.valid?
    assert_includes duplicada.errors[:title], 'ya está en uso'
  end

  test 'genera slug con friendly_id' do
    noticia = News.create!(noticias_validas)
    assert_equal 'noticia-unica', noticia.slug
  end

  test 'se asocia con tags' do
    noticia = News.create!(noticias_validas)
    tag = Tags::News.create!(name: 'mundial')
    Tags::NewsJoin.create!(news: noticia, tags_news: tag)
    assert_includes noticia.reload.tags_news, tag
  end
end
