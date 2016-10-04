class AddTeamIdAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :team, foreign_key: true
  end
end
