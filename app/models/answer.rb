class Answer < ActiveRecord::Base
  include Math::Comparison

  belongs_to :user
  belongs_to :question
  belongs_to :team

  validates :response, :answer_tex, :question, presence: true

  def initialize(attributes={})
    @for_test = attributes.delete(:test)
    super attributes
    before_initialize
  end

  private
  def before_initialize
    begin
      unless question.nil?
        set_correct

        unless @for_test
          set_progress
          set_attempt_number
        end
      end
    rescue Exceptions::MathematicalSyntaxError
      self.correct = false
      self.errors.add(:response, :invalid, message: 'Resposta não é valida')
    end
  end

  def set_correct
    service = Student::ResponseService.new question.correct_answer,
                                  response,
                                  question.precision

    self.correct = service.equal?
  end

  def set_progress
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
