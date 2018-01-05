class RemoveImages < ActiveRecord::Migration[5.1]
  def change
    remove_column :los, :image
    remove_column :teams, :image
    remove_column :users, :avatar
  end
end
