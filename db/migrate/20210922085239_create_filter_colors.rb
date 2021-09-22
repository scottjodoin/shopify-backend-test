class CreateFilterColors < ActiveRecord::Migration[6.0]
  def change
    create_table :filter_colors do |t|
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end
