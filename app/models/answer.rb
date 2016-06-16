class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  after_save :set_correct

  private
  def set_correct
    self.correct = question.correct_answer? response
  end
end
