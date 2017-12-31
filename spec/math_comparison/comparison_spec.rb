require 'rails_helper'
require 'math_comparison/comparison'

describe MathComparison::Comparison do
  context "when it's just an answer" do
    subject { MathComparison::Comparison.new correct_answer: '10', 
                                             precision:       1, 
                                             cmas_order:      false }

    it { is_expected.to be_right_response '10' }
    it { is_expected.to_not be_right_response '5' }
    it { is_expected.to be_right_response '5 + 5' }
    it { is_expected.to_not be_right_response '5 + 3' }
    it { is_expected.to be_right_response 'sqrt(100)' }
    it { is_expected.to_not be_right_response 'sqrt(49)' }
  end

  context "when it's more than one answer" do
    subject { MathComparison::Comparison.new correct_answer: '10;20', 
                                             precision:       1, 
                                             cmas_order:      false }
    
    it { is_expected.to be_right_response '10;20' }
    it { is_expected.to be_right_response '20;10' }
  end

  context "when it's more than one answer and in the same order" do
    subject { MathComparison::Comparison.new correct_answer: '10;20', 
                                             precision:       1, 
                                             cmas_order:      true }

    it { is_expected.to be_right_response '10;20' }
    it { is_expected.to_not be_right_response '20;10' }
  end

  context 'when it has three decimal places of precision' do
    subject { MathComparison::Comparison.new correct_answer: '2.5684952', 
                                             precision:       3, 
                                             cmas_order:      false }

    it { is_expected.to be_right_response '2.568' }
    it { is_expected.to_not be_right_response '2.56' }
    it { is_expected.to be_right_response '2.5684952' }
  end
end
