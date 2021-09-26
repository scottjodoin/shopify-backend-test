class AddDimensionsToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :width, :int
    add_column :posts, :height, :int
  end
end
