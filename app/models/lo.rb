class Lo < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
  validates_associated :user_id, presence: true

end
