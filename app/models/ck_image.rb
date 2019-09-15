class CkImage < ApplicationRecord
  belongs_to :user

  has_one :image, class_name: "Picture", as: :subject, dependent: :destroy

  accepts_nested_attributes_for :image

  validates :image, :user, presence: true
end
