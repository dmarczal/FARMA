class TipsCount < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :team


  def save_or_update
    tips_counts = TipsCount.where(["user_id = ? AND question_id = ? AND team_id = ?",
                             user.id, question.id, team.id])

    if tips_counts.empty?
      self.tries = 1
      save

      return self
    end

    tips_count = tips_counts[0]
    tips_count.update(tries: (tips_count.tries + 1))

    tips_count
  end
end
