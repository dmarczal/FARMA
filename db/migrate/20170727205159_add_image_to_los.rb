class AddImageToLos < ActiveRecord::Migration[5.0]
  def change
    add_column :los, :image, :string
  end
end
