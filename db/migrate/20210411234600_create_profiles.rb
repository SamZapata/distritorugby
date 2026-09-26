class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :user_id
      t.string :first_name
      t.string :last_name
      t.text :about
      t.datetime :bithday
      t.string :phone_number

      t.timestamps
    end
    add_index :profiles, :user_id, unique: true
  end
end
