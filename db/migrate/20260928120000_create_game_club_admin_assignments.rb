class CreateGameClubAdminAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :game_club_admin_assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :club, null: false, foreign_key: { to_table: :game_clubs }

      t.timestamps
    end

    add_index :game_club_admin_assignments, [:user_id, :club_id], unique: true
  end
end
