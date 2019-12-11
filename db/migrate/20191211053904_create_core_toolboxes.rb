class CreateCoreToolboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :core_toolboxes do |t|
      t.string :title
      t.string :description
      t.string :image
      t.string :video_embed

      t.timestamps
    end
  end
end
