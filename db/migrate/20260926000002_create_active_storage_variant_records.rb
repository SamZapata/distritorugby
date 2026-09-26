# Tabla de variantes de ActiveStorage (recortes/redimensionados), requerida por
# Rails 7.1 y ausente en la migración original del legacy (ActiveStorage 5.2).
class CreateActiveStorageVariantRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :active_storage_variant_records do |t|
      t.belongs_to :blob, null: false, index: false
      t.string :variation_digest, null: false

      t.index [:blob_id, :variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
    end

    add_foreign_key :active_storage_variant_records, :active_storage_blobs, column: :blob_id
  end
end
