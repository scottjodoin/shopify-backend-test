class RemoveExtraFieldsFromActiveStorageBlobs < ActiveRecord::Migration[6.0]
  def change
    remove_column :active_storage_blobs, :primary_color, :string
    remove_column :active_storage_blobs, :secondary_color, :string
    remove_column :active_storage_blobs, :fingerprint, :string
  end
end
  