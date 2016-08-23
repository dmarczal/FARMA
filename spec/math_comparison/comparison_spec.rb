require 'rails_helper'
require 'math_comparison/comparison'

describe 'the class comparison' do

  describe 'only one answer' do
    before :each do
      @comparison = MathComparison::Comparison.new(correct_answer: '10', precision: 1, cmas_order: false)
    end

    it 'the response must be correct' do
      expect(@comparison.right_response?('10')).to eq true
    end

    it 'the response must not be correct' do
      expect(@comparison.right_response?('5')).to eq false
    end

    it 'the sum must be correct' do
      expect(@comparison.right_response?('5 + 5')).to eq true
    end

    it 'the sum must not be correct' do
      expect(@comparison.right_response?('5 + 3')).to eq false
    end

    it 'the square root must be correct' do
      expect(@comparison.right_response?('sqrt(100)')).to eq true
    end

    it 'the square root must not be correct' do
      expect(@comparison.right_response?('sqrt(49)')).to eq false
    end
  end

  describe 'more than one answer and need not be in the same order' do
    before :each do
      @comparison = MathComparison::Comparison.new(correct_answer: '10;20', precision: 1, cmas_order: false)
    end

    it 'the answer must be correct' do
      expect(@comparison.right_response?('10;20')).to eq true
    end

    it 'the answer must not be correct' do
      expect(@comparison.right_response?('20;10')).to eq true
    end
  end

  describe 'more than one answer and needs to be in the same order' do
    before :each do
      @comparison = MathComparison::Comparison.new(correct_answer: '10;20', precision: 1, cmas_order: true)
    end

    it 'the answer must be correct' do
      expect(@comparison.right_response?('10;20')).to eq true
    end

    it 'the answer must not be correct' do
      expect(@comparison.right_response?('20;10')).to eq false
    end
  end

  describe 'with three decimal places of precision' do
    before :each do
      @comparison = MathComparison::Comparison.new(correct_answer: '2.5684952', precision: 3, cmas_order: false)
    end

    it 'the answer must be correct' do
      expect(@comparison.right_response?('2.568')).to eq true
    end

    it 'the answer must not be correct' do
      expect(@comparison.right_response?('2.56')).to eq false
    end

    it 'the answer must not be correct' do
      expect(@comparison.right_response?('2.5684952')).to eq true
    end
  end

end
