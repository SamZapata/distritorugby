class CreateGameSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :game_skills do |t|
      t.string :name
      t.text :description
      t.string :keyfactors, array: true
      t.string :image
      t.string :video_emb

      t.timestamps
    end
  end
end
