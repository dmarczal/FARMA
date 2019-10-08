class RemoveColumnFromQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :cmas_order, :boolean
  end
end
