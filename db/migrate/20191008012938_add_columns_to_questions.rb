class AddColumnsToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :answer_tex, :string, null: false, default: ''
    add_column :questions, :variables, 'char(1)', array: true, default: []
  end
end
