require 'rails_helper'

describe 'Lo features', type: :feature do
  let(:user) { create(:user, :actived) }
  let!(:lo) { create(:lo, user: user) }
  let(:breadcrumbs) { page.all('.breadcrumb').map { |breadcrumb| breadcrumb.text } }

  before { sign_in user }

  describe '#index' do
    let!(:los) { create_list(:lo, 5, user: user) }

    before { visit teacher_los_path }

    it 'display the all los' do
      los.each do |lo|
        expect(page).to have_content lo.name
      end
    end

    it 'display breadcrumbs' do
      expect(breadcrumbs).to eq ['Início', 'Meus OAs']
    end
  end

  describe "#create" do
    before { visit new_teacher_lo_path }

    it 'display breadcrumbs' do
      expect(breadcrumbs).to eq ['Início', 'Meus OAs', 'Novo OA']
    end

    context 'when all parameters sent are valid' do
      let(:params) {
        {
          'lo_name' => 'test',
          'lo_description' => 'test'
        }
      }

      it 'redirect to lo path' do
        fill_in_form '.simple_form', params

        expect(page.current_path).to eq teacher_lo_path(Lo.last)
      end

      it 'display the lo name on los list' do
        fill_in_form '.simple_form', params

        expect(page).to have_content 'test'
      end

      it 'creates new lo' do
        expect{
          fill_in_form '.simple_form', params
        }.to change(Lo,:count).by 1
      end
    end

    context 'when one or more parameters sent are invalid' do
      let(:params) {
        {
          'lo_name' => nil,
          'lo_description' => 'test'
        }
      }

      it 'will not create a lo' do
        expect{
          fill_in_form '.simple_form', params
        }.to_not change(Lo,:count)
      end
    end
  end

  describe "#update" do
    before { visit edit_teacher_lo_path(lo) }

    it 'display breadcrumbs' do
      expect(breadcrumbs).to eq ['Início', 'Meus OAs', "Editar #{lo.name}"]
    end

    context 'when all parameters sent are valid' do
      let(:params) {
        {
          'lo_name' => 'test',
          'lo_description' => 'test-description'
        }
      }

      before { fill_in_form '.simple_form', params }

      it 'redirect to teacher_los_path' do
        expect(page.current_path).to eq teacher_los_path
      end

      it 'display the name and description updated' do
        expect(page).to have_content('test') &&
                        have_content('test-description')
      end
    end

    context 'when one or more parameters sent are invalid' do
      let(:params) {
        {
          'lo_name' => nil,
          'lo_description' => 'test-description'
        }
      }

      it 'does not display the new description' do
        fill_in_form '.simple_form', params
        visit teacher_los_path

        expect(page).to_not have_content 'test-description'
      end
    end
  end

  describe '#show' do
    let!(:introduction) { create(:introduction, lo: lo) }
    let!(:exercise) { create(:exercise, lo: lo) }

    before { visit teacher_lo_path(lo) }

    it 'display breadcrumbs' do
      expect(breadcrumbs).to eq ['Início', 'Meus OAs', "OA #{lo.name}"]
    end

    it 'display the lo contents' do
      expect(page).to have_content(introduction.title) &&
                      have_content(exercise.title)
    end
  end

  describe '#delete' do
    before { visit teacher_los_path }

    it 'deletes the lo' do
      page.find('.destroy').click

      expect(Lo).to_not be_exists(lo.id)
    end
  end
end
