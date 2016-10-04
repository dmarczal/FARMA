class CreateLosTeams < ActiveRecord::Migration
  def change
    create_table :los_teams do |t|
      t.references :lo, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
