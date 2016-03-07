class CreateIntroductions < ActiveRecord::Migration
  def change
    create_table :introductions do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :position
      t.references :lo

      t.timestamps null: false
    end
  end
end
