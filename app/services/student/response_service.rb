class Student::ResponseService
  include Math::Comparison

  attr_accessor :correct_answer, :response, :precision

  def initialize(correct_answer, response, precision)
    @correct_answer = correct_answer.gsub('[', '(').gsub(']', ')')
    @response = response.gsub('[', '(').gsub(']', ')')
    @precision = precision
  end

  def equal?
    prepare_responses
    comparison = Comparator.make(self.correct_answer, self.response)
    comparison.equal?
  end

  private

  def prepare_responses
    return if precision.nil?

    Float(response)
    Float(correct_answer)

    self.correct_answer= slice_by_precision self.correct_answer
    self.response= slice_by_precision self.response
  end

  def slice_by_precision(math)
    return math unless math.include? '.'

    splited_response = math.split '.'
    splited_response[1] = splited_response[1].slice 0, precision

    splited_response.join('.')
  end
end
