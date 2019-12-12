class CreateRolesCoaches < ActiveRecord::Migration[5.2]
  def change
    create_table :roles_coaches do |t|
      t.text :about
      t.date :start_date
      t.string :image

      t.timestamps
    end
  end
end
