class CreateTipsCounts < ActiveRecord::Migration
  def change
    create_table :tips_counts do |t|
      t.integer :tries
      t.references :question, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
