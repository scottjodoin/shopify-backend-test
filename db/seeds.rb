# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

filter_colors = [
  {name: "Red", color: "F44336"},
  {name: "Orange", color: "FF9800"},
  {name: "Yellow", color: "FFEB3B"},
  {name: "Green", color: "4CAF50"},
  {name: "Teal", color: "00BCD4"},
  {name: "Blue", color: "2196F3"},
  {name: "Purple", color: "9C27B0"},
  {name: "Magenta", color: "E91E63"},
  {name: "White", color: "FFFFFF"},
  {name: "Grey", color: "9E9E9E"},
  {name: "Black", color: "000000"},
  {name: "Brown", color: "5D4037"}
]
FilterColor.create(filter_colors)