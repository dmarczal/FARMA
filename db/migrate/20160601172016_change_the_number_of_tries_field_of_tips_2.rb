class ChangeTheNumberOfTriesFieldOfTips2 < ActiveRecord::Migration
  def change
    add_column :tips, :number_of_tries, :integer, default: 1
  end
end
