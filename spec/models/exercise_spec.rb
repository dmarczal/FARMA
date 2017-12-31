require 'rails_helper'

RSpec.describe Exercise, type: :model do
  describe 'relationship' do
    it { is_expected.to belong_to(:lo) }
    it { is_expected.to have_many(:questions) }
    it { is_expected.to have_and_belong_to_many(:tags) }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:lo) }
  end
end
