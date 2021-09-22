class AddFilterColorKeysToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :primary_color, index: true, foreign_key: { to_table: :filter_colors }
    add_reference :posts, :secondary_color, index: true, foreign_key: { to_table: :filter_colors }
  end
end
