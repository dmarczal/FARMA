class Progress::Exercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  belongs_to :exercise, class_name: "::Exercise"

  validates :team, :exercise, :user, presence: true

  def set_progress(answer)
    if ::Answer.find_by(team_id: answer.team_id,
                        user_id: answer.user_id,
                        question_id: answer.question_id).nil?

      self.preview_percent += 1.0/exercise.questions_count * 100
    end

    if answer.correct and ::Answer.find_by(team_id: answer.team_id,
                                           user_id: answer.user_id,
                                           question_id: answer.question_id,
                                           correct: true).nil?

      self.progress_percent += 1.0/exercise.questions_count * 100
    end

    save!
  end
end
