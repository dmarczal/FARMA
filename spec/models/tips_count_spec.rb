require 'rails_helper'

RSpec.describe TipsCount , type: :model do
  describe 'relationship' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:team) }
    it { is_expected.to belong_to(:question) }
  end
end
