require 'math_comparison'

class Question < ActiveRecord::Base
  include MathComparison
  include AuthenticationAndPosition
  belongs_to :exercise, counter_cache: true
  has_many :tips

  validates :correct_answer, presence: true

  def correct_answer? response
    set_variables

    options = { variables:  @exp_variables,
               cmas_order: cmas_order,
               precision:  precision}

    right_response?(correct_answer, response, options)
  end

  private
  def right_response?(correct_answer, response, options)
    expression = MathComparison::Expression

    if many_answers?
      expression.eql_with_many_answers?(correct_answer, response, options)
    elsif eql_sinal?
      expression.eql_with_eql_sinal?(correct_answer, response, options)
    else
      expression.eql?(correct_answer, response, options)
    end
  end

  def many_answers?
    correct_answer.to_s.include?(';')
  end

  def eql_sinal?
    correct_answer.to_s.include?('=')
  end

  def set_variables
    @exp_variables ||= correct_answer.scan(/[a-z][a-z0-9_]*/).uniq
  end
end
