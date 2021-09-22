class ApplicationRecord < ActiveRecord::Base
  has_one :image_attachment, -> { where(name: 'image') }, class_name: "ActiveStorage::Attachment", as: :record, inverse_of: :record, dependent: false
  has_one :image_blob, through: :image_attachment, class_name: "ActiveStorage::Blob", source: :blob

  self.abstract_class = true
end
