class CreateGameCategorySchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :game_category_schedules do |t|
      t.string :day
      t.time :start_time
      t.time :end_time
      t.integer :club_category_id

      t.timestamps
    end
  end
end
