class CreateProgressExercises < ActiveRecord::Migration[5.0]
  def change
    create_table :progress_exercises do |t|
      t.references :team, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :exercise, index: true, foreign_key: true
      t.float :progress_percent, default: 0
      t.float :preview_percent, default: 0

      t.timestamps null: false
    end
  end
end
