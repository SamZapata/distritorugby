class RenameCaptionToNews < ActiveRecord::Migration[5.2]
  def change
    rename_column :news, :caption, :summary
  end
end
