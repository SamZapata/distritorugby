class CreateGamePrinciples < ActiveRecord::Migration[5.2]
  def change
    create_table :game_principles do |t|
      t.string :name
      t.text :description
      t.string :stage
      t.string :image
      t.string :video_emb

      t.timestamps
    end
  end
end
