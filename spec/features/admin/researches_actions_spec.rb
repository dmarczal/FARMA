require 'rails_helper'

describe 'Admin Research features', type: :feature do
  let(:admin) { create(:admin) }
  before { sign_in admin }

  describe '#index' do
    it 'display the all los' do
      reseaches = create_list(:admin_research, 5)

      visit admin_researches_path

      reseaches.each do |research|
        expect(page).to have_content research.title
        expect(page).to have_link href: admin_research_path(research)
        expect(page).to have_link href: edit_admin_research_path(research)
      end
    end
  end

  describe '#delete' do
    it 'deletes the research' do
      research = create(:admin_research)

      visit admin_researches_path

      page.find('.destroy').click

      expect(Admin::Research).to_not be_exists(research.id)
      expect(current_path).to eq(admin_researches_path)
      expect(page).to_not have_content(research.title)
    end
  end

  describe '#update' do
    before do
      @c = create(:admin_research_category)
      @research = create(:admin_research)
      visit edit_admin_research_path(@research)
    end

    context 'when all parameters sent are valid' do
      let(:params) do
        {
          'admin_research_title' => 'New title',
          'admin_research_ref' => 'New ref',
          'admin_research_abstract' => 'New abstract',
          'admin_research_link' => 'https://new'
        }
      end

      before do
        fill_in_form '.simple_form', params do
          r = 'research'
          select @c.name, from: "admin_#{r}_#{r}_category_id", visible: false
        end
      end

      it 'redirect to admin_research_path' do
        expect(page.current_path).to eq admin_research_path(@research)
      end

      it 'display the params updated' do
        expect(page).to have_content('New title')
      end
    end

    context 'when all parameters sent are invalid' do
      let(:params) do
        {
          'admin_research_title' => '',
          'admin_research_ref' => '',
          'admin_research_abstract' => '',
          'admin_research_link' => ''
        }
      end

      before do
        fill_in_form '.simple_form', params do
          select '', from: 'admin_research_research_category_id', visible: false
        end
      end

      it 'redirect to edit_admin_research_path' do
        expect(page.current_path).to eq admin_research_path(@research)
      end

      it 'display the error message when the input is empty' do
        within('div.admin_research_title') do
          expect(page).to have_content('não pode ficar em branco')
        end

        within('div.admin_research_ref') do
          expect(page).to have_content('não pode ficar em branco')
        end

        within('div.admin_research_abstract') do
          expect(page).to have_content('não pode ficar em branco')
        end

        within('div.admin_research_link') do
          expect(page).to have_content('não pode ficar em branco')
        end

        within('div.admin_research_research_category') do
          expect(page).to have_content('não pode ficar em branco')
        end
      end
    end

    it 'display the error message when the value is already taken' do
      research = create(:admin_research)
      params = { admin_research_title: research.title,
                 admin_research_abstract: research.abstract,
                 admin_research_link: research.link }

      fill_in_form '.simple_form', params

      within('div.admin_research_title') do
        expect(page).to have_content('já está em uso')
      end

      within('div.admin_research_abstract') do
        expect(page).to have_content('já está em uso')
      end

      within('div.admin_research_link') do
        expect(page).to have_content('já está em uso')
      end
    end
  end
end
