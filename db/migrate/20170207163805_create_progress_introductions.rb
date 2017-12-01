class CreateProgressIntroductions < ActiveRecord::Migration[5.0]
  def change
    create_table :progress_introductions do |t|
      t.references :team, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :introduction, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
