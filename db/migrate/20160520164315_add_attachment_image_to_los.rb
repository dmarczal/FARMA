class AddAttachmentImageToLos < ActiveRecord::Migration
  def self.up
    change_table :los do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :los, :image
  end
end
