class ChangeTheNumberOfTriesFieldOfTips2 < ActiveRecord::Migration[5.0]
  def change
    add_column :tips, :number_of_tries, :integer, default: 1
  end
end
