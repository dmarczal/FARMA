class Picture < ApplicationRecord
  belongs_to :subject, polymorphic: true

  attachment :image, type: :image
end
