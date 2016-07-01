require 'comparison'

class Question < ActiveRecord::Base
  include MathComparison
  include AuthenticationAndPosition
  attr_reader :math_comparison

  belongs_to :exercise, counter_cache: true
  has_many :tips

  validates :correct_answer, presence: true

  after_initialize :set_math_comparison

  private
  def set_math_comparison
    @math_comparison = Comparison.new(correct_answer, cmas_order, precision)
  end
end
