require 'rails_helper'

describe "Introduction features" do
  let(:user) { create(:user, :actived) }
  let(:lo) { create(:lo, user: user) }
  let(:introduction) { create(:introduction, lo: lo) }

  before { sign_in user }

  describe '#new' do
    it 'display the "New Introduction"' do
      visit(new_teacher_lo_introduction_path(lo))

      expect(page).to have_content 'Nova Introdução'
    end
  end

  describe '#edit' do
    it 'display the "Edit Introduction"' do
      visit(edit_teacher_lo_introduction_path(lo, introduction))

      expect(page).to have_content truncate("Editar Introdução", length: 25)
    end
  end

  describe '#create' do
    context 'when all parameters sent are valid' do
      let(:params) {
        {
          'introduction_title' => 'test',
          'introduction_content' => 'test'
        }
      }

      it 'should add one new introduction' do
        visit(new_teacher_lo_introduction_path(lo))
  
        expect{
          fill_in_form '.simple_form', params
        }.to change(Introduction,:count).by 1
      end
    end

    
    context 'when one or more parameters sent are invalid' do
      let(:params) {
        {
          'introduction_title' => nil,
          'introduction_content' => 'test'
        }
      }

      it 'should not add one new introduction' do
        visit(new_teacher_lo_introduction_path(lo))
  
        expect{
          fill_in_form '.simple_form', params
        }.to_not change(Introduction,:count)
      end
    end
  end

  describe '#update' do
    before { visit(edit_teacher_lo_introduction_path(lo, introduction)) }

    context 'when all parameters sent are valid' do
      let(:params) { 
        {
          'introduction_title' => 'test',
          'introduction_content' => 'test'
        }
      }

      it 'updates the introduction' do
        fill_in_form '.simple_form', params

        introduction.reload

        expect(introduction.as_json).to include({'title' => 'test', 'content' => 'test'})
      end
    end

    context 'when one or more parameters sent are invalid' do
      let(:params) { 
        {
          'introduction_title' => nil,
          'introduction_content' => 'test'
        }
      }

      it 'does not updates the introduction' do
        fill_in_form '.simple_form', params

        introduction.reload

        expect(introduction.as_json).to_not include({'title' => 'test', 'content' => 'test'})
      end
    end
  end

  describe '#delete' do
    it 'deletes the introduction' do
      page.driver.submit :delete, teacher_lo_introduction_path(lo, introduction), {}
  
      expect(Introduction).to_not be_exists(introduction.id)
    end
  end
end
