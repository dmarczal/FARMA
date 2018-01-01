require 'rails_helper'

RSpec.describe Tip, type: :model do
  subject { build(:tip) }

  describe 'relationship' do
    it { is_expected.to belong_to(:question) }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:number_of_tries) }
    it { is_expected.to validate_numericality_of(:number_of_tries).
                                                is_greater_than(0).
                                                only_integer }

    it { is_expected.to validate_uniqueness_of(:number_of_tries).scoped_to(:question_id) }
  end
end
