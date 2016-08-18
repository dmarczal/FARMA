class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  after_initialize :correct_answer

  private
  def correct_answer
    comparison = MathComparison::Comparison.new(correct_answer: question.correct_answer,precision: question.precision, cmas_order: question.cmas_order)
    self.correct = comparison.right_response?(response)
  end
end
