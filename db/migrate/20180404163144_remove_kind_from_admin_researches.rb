class RemoveKindFromAdminResearches < ActiveRecord::Migration[5.1]
  def change
    remove_column :admin_researches, :kind
  end
end
