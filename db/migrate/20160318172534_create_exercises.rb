class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :position
      t.integer :questions_count
      t.references :lo

      t.timestamps null: false
    end
  end
end
