class CreateCompetenceStats < ActiveRecord::Migration[5.2]
  def change
    create_table :competence_stats do |t|
      t.integer :trys_t1
      t.integer :trys_t2
      t.integer :conversion_t1
      t.integer :conversion_t2
      t.integer :dropgoal_t1
      t.integer :dropgoal_t2
      t.integer :penalties_t1
      t.integer :penalties_t2
      t.integer :yellows_t1
      t.integer :yellows_t2
      t.integer :reds_t1
      t.integer :reds_t2
      t.integer :tackles_t1
      t.integer :tackles_t2
      t.integer :scrums_t1
      t.integer :scrums_t2
      t.integer :won_scrums_t1
      t.integer :won_scrums_t2
      t.integer :lines_t1
      t.integer :lines_t2
      t.integer :won_lines_t1
      t.integer :won_lines_t2
      t.integer :mauls_t1
      t.integer :mauls_t2
      t.integer :possession_t1
      t.integer :possession_t2

      t.timestamps
    end
  end
end
