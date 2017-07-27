class RemoveAttachmentToUsersAndLos < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :users, :avatar
    remove_attachment :los, :image
  end
end
