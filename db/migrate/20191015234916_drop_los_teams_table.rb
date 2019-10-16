class DropLosTeamsTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :los_teams
  end
end
