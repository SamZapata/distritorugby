require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  def historia_con_imagen
    historia = Story.new(
      name: 'Historia unica',
      summary: 'Resumen',
      body: 'Cuerpo',
      image_caption: 'Pie'
    )
    historia.image.attach(
      io: StringIO.new('contenido-de-prueba'),
      filename: 'foto.png',
      content_type: 'image/png'
    )
    historia
  end

  test 'es valida con los atributos requeridos' do
    assert historia_con_imagen.valid?
  end

  test 'requiere name, summary, body, image e image_caption' do
    historia = Story.new
    assert_not historia.valid?
    assert_includes historia.errors[:name], 'no puede estar en blanco'
    assert_includes historia.errors[:summary], 'no puede estar en blanco'
    assert_includes historia.errors[:body], 'no puede estar en blanco'
    assert_includes historia.errors[:image], 'no puede estar en blanco'
    assert_includes historia.errors[:image_caption], 'no puede estar en blanco'
  end

  test 'requiere name unico' do
    historia_con_imagen.save!
    duplicada = Story.new(
      name: 'Historia unica',
      summary: 'Otro resumen',
      body: 'Otro cuerpo',
      image_caption: 'Otro pie'
    )
    duplicada.image.attach(
      io: StringIO.new('otro-contenido'),
      filename: 'otro.png',
      content_type: 'image/png'
    )
    assert_not duplicada.valid?
    assert_includes duplicada.errors[:name], 'ya está en uso'
  end

  test 'genera slug con friendly_id' do
    historia = historia_con_imagen.tap(&:save!)
    assert_equal 'historia-unica', historia.slug
  end

  test 'permite adjuntar una imagen con active storage' do
    historia = historia_con_imagen.tap(&:save!)
    assert historia.image.attached?
    assert_equal 'foto.png', historia.image.filename.to_s
  end

  test 'destruye una historia con joins de tags sin error de inverse_of' do
    historia = historia_con_imagen.tap(&:save!)
    tag = Tags::Story.create!(name: 'tradicion')
    Tags::StoryJoin.create!(story: historia, tags_story: tag)

    assert_difference 'Tags::StoryJoin.count', -1 do
      assert_difference 'Story.count', -1 do
        historia.destroy!
      end
    end
  end

  test 'destruye un tag de historia con joins sin error de inverse_of' do
    historia = historia_con_imagen.tap(&:save!)
    tag = Tags::Story.create!(name: 'leyendas')
    Tags::StoryJoin.create!(story: historia, tags_story: tag)

    assert_difference 'Tags::StoryJoin.count', -1 do
      assert_difference 'Tags::Story.count', -1 do
        tag.destroy!
      end
    end
  end
end
