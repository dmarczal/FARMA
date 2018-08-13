class CreateAdminDevelopers < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_developers do |t|
      t.string :name
      t.string :function
      t.string :institution
      t.string :link
      t.date :start_on_project
      t.date :leave_project
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
