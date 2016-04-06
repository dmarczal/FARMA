class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.text :content, null: false
      t.integer :number_of_tries, default: 0
      t.references :question

      t.timestamps null: false
    end
  end
end
