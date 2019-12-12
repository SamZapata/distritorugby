class CreateUsersProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :users_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.integer :age
      t.float :height
      t.float :weight
      t.string :nickname
      t.string :phone
      t.string :socialmedia
      t.string :webpage
      t.string :image

      t.timestamps
    end
  end
end
