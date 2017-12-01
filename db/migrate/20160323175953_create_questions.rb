class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.integer :position
      t.text :content, null: false
      t.text :correct_answer, null: false
      t.integer :precision
      t.boolean :cmas_order
      t.references :exercise

      t.timestamps null: false
    end
  end
end
