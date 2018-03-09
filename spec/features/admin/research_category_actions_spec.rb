require 'rails_helper'

describe 'Admin Research Categories features', type: :feature do
  let(:admin) { create(:admin) }

  before { sign_in admin }

  describe '#index' do

    it 'display the all los' do
      categories = create_list(:admin_research_category, 5)

      visit admin_research_categories_path

      categories.each do |category|
        expect(page).to have_content category.name
      end
    end

  end
end
