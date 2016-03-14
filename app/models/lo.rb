class Lo < ActiveRecord::Base
  belongs_to :user
  has_many :introduction
  has_many :exercise

  validates :name, :description, :user, presence: true


end
