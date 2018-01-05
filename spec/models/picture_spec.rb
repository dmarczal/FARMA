require 'rails_helper'

RSpec.describe Picture, type: :model do
  let(:picture) { create(:picture) }
  let(:pattern) { /\/attachments\/[a-z|A-Z|0-9]+\/store\/[a-z|A-Z|0-9]+\/logo.png/ }
  let(:invalid_picture) { build(:picture, :text_file) }

  it 'returns the image url' do
    expect(Refile.attachment_url(picture, :image)).to match(pattern)
  end

  it 'is invalid' do
    expect(invalid_picture).to_not be_valid
  end

  describe 'relationships' do
    it { is_expected.to belong_to(:subject) }
  end
end
