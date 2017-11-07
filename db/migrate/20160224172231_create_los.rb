class CreateLos < ActiveRecord::Migration[5.0]
  def change
    create_table :los do |t|
      t.string :name, null: false, default: ""
      t.text :description, null: false, default: ""
      t.integer :introductions_count, default: 0
      t.integer :exercises_count, default: 0
      t.references :user

      t.timestamps null: false
    end

  end
end
