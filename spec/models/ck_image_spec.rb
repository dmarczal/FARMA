require 'rails_helper'

RSpec.describe CkImage, type: :model do
  describe 'relationship' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_one(:image).dependent(:destroy) }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:image) }
  end
end
