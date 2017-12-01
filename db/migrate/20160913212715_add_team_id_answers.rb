class AddTeamIdAnswers < ActiveRecord::Migration[5.0]
  def change
    add_reference :answers, :team, foreign_key: true
  end
end
