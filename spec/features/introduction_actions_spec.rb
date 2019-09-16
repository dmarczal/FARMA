require 'rails_helper'

describe "Introduction features" do
  let(:user) { create(:user, :actived) }
  let(:lo) { create(:lo, user: user) }
  let(:introduction) { create(:introduction, lo: lo) }
  let(:breadcrumbs) { page.all('.breadcrumb').map { |breadcrumb| breadcrumb.text } }

  before { sign_in user }

  describe '#edit' do
    it 'display the "Edit Introduction"' do
      visit(edit_teacher_lo_introduction_path(lo, introduction))

      expect(page).to have_content truncate("Editar Introdução", length: 25)
    end
  end

  describe '#create' do
    before { visit(new_teacher_lo_introduction_path(lo)) }

    it 'display breadcrumbs' do
      expect(breadcrumbs).to eq ['Início', 'Meus OAs', "OA #{lo.name}", 'Nova Introdução']
    end

    context 'when all parameters sent are valid' do
      let(:params) {
        {
          'introduction_title' => 'test',
          'introduction_content' => 'test'
        }
      }

      it 'creates a new introduction' do
        expect{
          fill_in_form '.simple_form', params
        }.to change(Introduction,:count).by 1
      end

      it 'display the introduction title' do
        fill_in_form '.simple_form', params

        expect(page).to have_content 'test'
      end

      it 'redirect to introduction path' do
        fill_in_form '.simple_form', params

        expect(page.current_path).to eq teacher_lo_path(lo)
      end
    end


    context 'when one or more parameters sent are invalid' do
      let(:params) {
        {
          'introduction_title' => nil,
          'introduction_content' => 'test'
        }
      }

      it 'does not creates the introduction' do
        visit(new_teacher_lo_introduction_path(lo))

        expect{
          fill_in_form '.simple_form', params
        }.to_not change(Introduction, :count)
      end
    end
  end

  describe '#update' do
    before { visit(edit_teacher_lo_introduction_path(lo, introduction)) }

    it 'display breadcrumbs' do
      expect(breadcrumbs).to eq ['Início', 'Meus OAs', "OA #{lo.name}", 'Editar Introdução']
    end

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

      it 'display the introduction title' do
        fill_in_form '.simple_form', params

        expect(page).to have_content 'test'
      end

      it 'redirect to introduction path' do
        fill_in_form '.simple_form', params

        expect(page.current_path).to eq teacher_lo_introduction_path(lo, introduction)
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

    it 'redirect to lo path' do
      page.driver.submit :delete, teacher_lo_introduction_path(lo, introduction), {}

      expect(page.current_path).to eq teacher_lo_path(lo)
    end
  end
end
