class AddOpenedToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :opened, :boolean
  end
end
