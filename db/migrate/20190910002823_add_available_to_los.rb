class AddAvailableToLos < ActiveRecord::Migration[5.1]
  def change
    add_column :los, :available, :boolean, null: false, default: false
  end
end
