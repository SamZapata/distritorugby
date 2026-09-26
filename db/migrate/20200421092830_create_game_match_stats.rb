class CreateGameMatchStats < ActiveRecord::Migration[5.2]
  def change
    create_table :game_match_stats do |t|
      t.integer :tries_a
      t.integer :tries_b
      t.integer :conversions_a
      t.integer :conversions_b
      t.integer :penalty_goal_a
      t.integer :penalty_goal_b
      t.integer :drop_goal_a
      t.integer :drop_goal_b
      t.integer :scrums_a
      t.integer :scrums_b
      t.integer :lines_a
      t.integer :lines_b
      t.integer :mauls_a
      t.integer :mauls_b
      t.integer :handling_a
      t.integer :handling_b
      t.integer :yellows_a
      t.integer :yellows_b
      t.integer :reds_a
      t.integer :reds_b
      t.integer :penalties_a
      t.integer :penalties_b
      t.integer :match_id

      t.timestamps
    end
  end
end
