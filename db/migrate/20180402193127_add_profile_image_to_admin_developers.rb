class AddProfileImageToAdminDevelopers < ActiveRecord::Migration[5.1]
  def change
    add_column :admin_developers, :profile_image_id, :string
  end
end
