class AddColumnAnswerTexToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :answer_tex, :string, null: false
  end
end
