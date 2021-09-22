class Post < ApplicationRecord
  has_one_attached :image, :dependent => :destroy
  belongs_to :primary_color, class_name: "FilterColor", optional: true
  belongs_to :secondary_color, class_name: "FilterColor", optional: true
  #validates :title, presence: true
end
