class AddImageToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :image, :string
  end
end
