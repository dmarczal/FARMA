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
        expect(page).to have_link href: admin_research_category_path(category)
        expect(page).to have_link href: edit_admin_research_category_path(category)
      end

    end

  end

  describe '#delete' do

    it 'deletes the research category' do
      category = create(:admin_research_category)

      visit admin_research_categories_path

      page.find('.destroy').click

      expect(Admin::ResearchCategory).to_not be_exists(category.id)
      expect(current_path).to eq(admin_research_categories_path)
      expect(page).to_not have_content(category.name)
    end

    #context 'when the category is in a research' do
    #end
  end

  describe '#update' do
    before do
      @category = create(:admin_research_category)
      visit edit_admin_research_category_path(@category)
    end

    context 'when all parameters sent are valid' do
      let(:params) {
        {
          'admin_research_category_name' => 'New name',
        }
      }

      before { fill_in_form '.simple_form', params }

      it 'redirect to admin_research_categories_path' do
        expect(page.current_path).to eq admin_research_categories_path
      end

      it 'display the name updated' do
        expect(page).to have_content('New name')
      end
    end

    context 'when all parameters sent are invalid' do
      let(:params) {
        {
          'admin_research_category_name' => '',
        }
      }

      before { fill_in_form '.simple_form', params }

      it 'redirect to edit_admin_research_category_path' do
        expect(page.current_path).to eq admin_research_category_path(@category)
      end

      it 'display the error message' do
        within('div.admin_research_category_name') do
          expect(page).to have_content('não pode ficar em branco')
        end
      end
    end

  end
end
