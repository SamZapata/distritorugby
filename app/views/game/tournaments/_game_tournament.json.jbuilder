json.extract! game_tournament, :id, :name, :start_date, :end_date, :about, :country, :region, :city, :organizer, :created_at, :updated_at
json.url game_tournament_url(game_tournament, format: :json)
