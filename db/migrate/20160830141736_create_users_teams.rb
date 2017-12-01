class CreateUsersTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :users_teams do |t|
      t.references :user, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
