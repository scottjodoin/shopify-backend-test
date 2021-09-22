class FilterColor < ApplicationRecord
  has_many :primary_color_images, :class_name => 'Post', :foreign_key => 'primary_color_id'
  has_many :secondary_color_images, :class_name => 'Post', :foreign_key => 'secondary_color_id'
end
