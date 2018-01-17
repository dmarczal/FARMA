require 'rails_helper'

RSpec.describe Lo, type: :model do
  describe 'relationship' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:introductions).dependent(:destroy) }
    it { is_expected.to have_many(:exercises).dependent(:destroy) }
    it { is_expected.to have_many(:progress_los).class_name('Progress::Lo') }
    it { is_expected.to have_and_belong_to_many(:teams) }
    it { is_expected.to have_and_belong_to_many(:tags) }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe '#contents' do
    let(:lo) { create(:lo) }
    let!(:contents) do
      allow_any_instance_of(Exercise).to receive(:default_position)
      allow_any_instance_of(Introduction).to receive(:default_position)

      [
        create(:exercise, lo: lo, position: 1.second.from_now.to_i),
        create(:introduction, lo: lo, position: 2.second.from_now.to_i),
        create(:exercise, lo: lo, position: 3.second.from_now.to_i),
        create(:introduction, lo: lo, position: 4.second.from_now.to_i)
      ]
    end

    it 'returns the contents in position order' do
      expect(lo.contents).to eq contents
    end
  end
end
