class AddFingerprintToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :fingerprint, :string
  end
end
