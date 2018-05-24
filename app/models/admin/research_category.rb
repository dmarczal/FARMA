class Admin::ResearchCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_many :researches, dependent: :restrict_with_error
  validates_associated :researches
end
