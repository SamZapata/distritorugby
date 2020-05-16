json.extract! game_match, :id, :play_date, :play_time, :emb_location, :address, :created_at, :updated_at
json.url game_match_url(game_match, format: :json)
