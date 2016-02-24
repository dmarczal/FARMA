class Lo < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
end
