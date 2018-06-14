class Admin::Research < ApplicationRecord
  validates :title, :ref, :abstract, :link, presence: true
  validates :research_category_id, presence: true
  validates :title, :abstract, :link, uniqueness: { case_sensitive: false }
  validates :link, url: true
  belongs_to :research_category
end
