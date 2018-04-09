class Admin::Developer < ApplicationRecord

  attachment :profile_image

  validates :name, :link, :function, :institution, :start_on_project, presence: true
  validates_presence_of :leave_project, :if => lambda { |o| o.active == false } 

end
