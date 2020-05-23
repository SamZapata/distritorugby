json.extract! game_player, :id, :first_name, :last_name, :identification, :birthdate, :eps, :weigth, :height, :position, :phone, :injuries, :about, :email, :created_at, :updated_at
json.url game_player_url(game_player, format: :json)
