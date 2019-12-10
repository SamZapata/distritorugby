class RenameCaptionToNews < ActiveRecord::Migration[5.2]
  def change
    rename_column :core_news, :caption, :summary
  end
end
