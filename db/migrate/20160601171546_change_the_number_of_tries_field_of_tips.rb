class ChangeTheNumberOfTriesFieldOfTips < ActiveRecord::Migration[5.0]
  def up
    remove_column :tips, :number_of_tries
  end

  def down
    add_column :tips, :number_of_tries, :integer, default: 1
  end
end
