require 'rails_helper'

RSpec.describe Admin::Research, type: :model do
  describe 'validates' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:ref) }
    it { is_expected.to validate_presence_of(:abstract) }
    it { is_expected.to validate_presence_of(:link) }
    it { is_expected.to validate_presence_of(:research_category_id) }

    it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:abstract).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:link).case_insensitive }

    it "should accept a valid url" do
      research = FactoryBot.build(:admin_research)

      valid_urls = %w[https://www.google.com http://tcc.tsi.gp.utfpr.edu.br]
      valid_urls.each do |valid_url|
        research.link= valid_url
        expect(research).to be_valid, "#{valid_url} should be valid"
      end
    end
  end
end
