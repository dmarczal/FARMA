class Lo < ActiveRecord::Base
  belongs_to :user
  has_many :introduction

  validates :name, :description, :user, presence: true


end
