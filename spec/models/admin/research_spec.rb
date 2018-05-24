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
  end
end
