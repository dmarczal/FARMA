class CreateAdminResearches < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_researches do |t|
      t.string :title
      t.text :ref
      t.text :abstract
      t.string :link
      t.string :kind

      t.timestamps null: false
    end
  end
end
