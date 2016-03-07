class Lo < ActiveRecord::Base
  belongs_to :user
  has_many :introduction , dependent: :destroy

  validates :name, :description, :user, presence: true


end
