class Answer < ActiveRecord::Base
  include Math::Comparison

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
    begin
      correct_answer, response = prepare_responses
      comparison = Comparator.make(correct_answer, response)

      self.correct = comparison.equal?
    rescue ArgumentError => exception
      self.correct = false
    end

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

  def prepare_responses
    return [question.correct_answer, response] if question.precision.nil?

    Float(response)
    Float(question.correct_answer)
    responses = []
    responses.push slice_by_precision(question.correct_answer)
    responses.push slice_by_precision(response)

    responses
  end

  def slice_by_precision(math)
    return math unless math.include? '.'

    splited_response = math.split '.'
    splited_response[1] = splited_response[1].slice 0, question.precision

    splited_response.join('.')
  end
end
