class Core::Base::FiltersByModel
  def call
    {
      objects: [
        { model: 'News', name: 'Noticias', path: '/news' },
        { model: 'Club', name: 'Clubes', path: '/game/clubs' },
        { model: 'Player', name: 'Jugadores', path: '/game/players' },
        { model: 'Coach', name: 'Entrenadores', path: '/game/coaches' },
        { model: 'Tournament', name: 'Torneos', path: '/game/tournaments' }
      ]
    }
  end
end
