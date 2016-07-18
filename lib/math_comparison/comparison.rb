require 'math_comparison/version'
require 'math_comparison/expression'

module MathComparison
  include Expression
  
  class Comparison

    def initialize(options)
      @correct_answer = options.delete(:correct_answer)
      @options = options
    end

    def right_response?(response)
      if many_answers?
        Expression.eql_with_many_answers?(@correct_answer, response, @options)
      elsif eql_sinal?
        Expression.eql_with_eql_sinal?(@correct_answer, response, @options)
      else
        Expression.eql?(@correct_answer, response, @options)
      end
    end

    private
    def many_answers?
      @correct_answer.to_s.include?(';')
    end

    def eql_sinal?
      @correct_answer.to_s.include?('=')
    end
  end
end
