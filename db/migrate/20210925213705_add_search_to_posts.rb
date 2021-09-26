class AddSearchToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :search, :boolean, :default => false
  end
end
