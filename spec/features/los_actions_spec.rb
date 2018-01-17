require 'rails_helper'

describe "Lo features" do
  let(:user) { create(:user, :actived) }
  let(:lo) { create(:lo, user: user) }

  before { sign_in user }

  describe "#create" do
    before { visit new_teacher_lo_path }

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
    before do 
      visit edit_teacher_lo_path(lo)
      fill_in_form '.simple_form', params
    end

    context 'when all parameters sent are valid' do
      let(:params) {
        {
          'lo_name' => 'test',
          'lo_description' => 'test-description'
        }
      }

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
        visit teacher_los_path

        expect(page).to_not have_content 'test-description'
      end
    end
  end

  describe '#show' do
    let!(:introduction) { create(:introduction, lo: lo) }
    let!(:exercise) { create(:exercise, lo: lo) }

    it 'display the lo contents' do
      visit teacher_lo_path(lo)

      expect(page).to have_content(introduction.title) &&
                      have_content(exercise.title)
    end
  end

  describe '#delete' do
    it 'deletes the lo' do
      page.driver.submit :delete, teacher_lo_path(lo), {}

      expect(Lo).to_not be_exists(lo.id)
    end
  end
end
