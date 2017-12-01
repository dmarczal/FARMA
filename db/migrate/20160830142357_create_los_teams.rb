class CreateLosTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :los_teams do |t|
      t.references :lo, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
