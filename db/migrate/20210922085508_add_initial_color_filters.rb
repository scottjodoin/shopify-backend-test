class AddInitialColorFilters < ActiveRecord::Migration[6.0]
  def up
    FilterColor.create(name: "Red", color: "F44336")
    FilterColor.create(name: "Orange", color: "FF9800")
    FilterColor.create(name: "Yellow", color: "FFEB3B")
    FilterColor.create(name: "Green", color: "4CAF50")
    FilterColor.create(name: "Teal", color: "00BCD4")
    FilterColor.create(name: "Blue", color: "2196F3")
    FilterColor.create(name: "Purple", color: "9C27B0")
    FilterColor.create(name: "Magenta", color: "E91E63")
    FilterColor.create(name: "White", color: "FFFFFF")
    FilterColor.create(name: "Grey", color: "9E9E9E")
    FilterColor.create(name: "Black", color: "000000")
    FilterColor.create(name: "Brown", color: "5D4037")
  end

  def down
    FilterColor.delete_all
  end
end
