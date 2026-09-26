# ActiveStorage desde Rails 7.0 exige service_name en los blobs. La migración
# original del legacy viene de ActiveStorage 5.2 y no incluye esta columna.
class AddServiceNameToActiveStorageBlobs < ActiveRecord::Migration[7.1]
  def change
    add_column :active_storage_blobs, :service_name, :string, null: false, default: 'local'
  end
end
