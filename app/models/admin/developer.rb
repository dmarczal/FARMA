class Admin::Developer < ApplicationRecord
  attachment :profile_image
  validates :name, :link, :function, :institution, :start_on_project, presence: true
  validates :leave_project, presence: true, if: :active_on_project?
  validates :link, url: true
  scope :actives, -> { where(active: true) }
  scope :inactives, -> { where(active: false) }

  def active_on_project?
    active == false
  end
end
