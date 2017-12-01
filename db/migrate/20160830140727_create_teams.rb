class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :code
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
