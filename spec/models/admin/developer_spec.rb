require 'rails_helper'

RSpec.describe Admin::Developer, type: :model do

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:link) }
    it { is_expected.to validate_presence_of(:function) }
    it { is_expected.to validate_presence_of(:institution) }
    it { is_expected.to validate_presence_of(:start_on_project) }
    
  end
end
