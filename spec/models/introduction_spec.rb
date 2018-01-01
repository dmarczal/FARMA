require 'rails_helper'

RSpec.describe Introduction, type: :model do
  describe 'relationship' do
    it { is_expected.to belong_to(:lo) }
    it { is_expected.to have_many(:progress_introductions).class_name('Progress::Introduction') }
    it { is_expected.to have_and_belong_to_many(:tags) }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:lo) }
  end
end
