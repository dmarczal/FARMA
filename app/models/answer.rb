class Answer < ActiveRecord::Base
  include MathComparison

  belongs_to :user
  belongs_to :question
  belongs_to :team

  def initialize(attributes={})
    for_test = attributes.delete(:test)
    super attributes

    set_correct
    unless for_test
      set_attempt_number
    end
  end

  def response=(value)
    super value

    unless question.nil?
      set_correct
    end
  end

  private
  def set_correct
    comparison = MathComparison::Comparison.new(correct_answer: question.correct_answer,precision: question.precision, cmas_order: question.cmas_order)
    self.correct = comparison.right_response?(response)

    unless team.nil?
      progress = team.progress_lo.find_or_create_by(user_id: user_id, team_id: team_id, lo_id: question.exercise.lo_id)
      progress.previewed_an_exercise self
    end
  end

  def set_attempt_number
    if team.nil?
      last_answer = Answer.where(["user_id = ? AND question_id = ?",
                                    user.id, question.id])
    else
      last_answer = Answer.where(["user_id = ? AND question_id = ? AND team_id = ?",
                                    user.id, question.id, team.id])
    end

    if last_answer[0].nil?
      self.attempt_number = 1
    else
      self.attempt_number = last_answer.last.attempt_number + 1
    end
  end
end
