require 'rails_helper'

describe 'Exercise features' do
  let(:user) { create(:user, :actived) }
  let(:lo) { create(:lo, user: user) }
  let(:exercise) { create(:exercise, lo: lo) }
  let(:breadcrumbs) { page.all('.breadcrumb').map { |breadcrumb| breadcrumb.text } }

  before { sign_in user }

  describe '#show' do
    it 'display the correct' do
      visit(teacher_lo_exercise_path(lo, exercise))

      expect(page).to have_content truncate("Questões do exercicio #{exercise.title}", length: 25)
    end
  end

  describe '#create' do
    before { visit(new_teacher_lo_exercise_path(lo)) }

    it 'display breadcrumbs' do
      expect(breadcrumbs).to eq ['Início', 'Meus OAs', "OA #{lo.name}", 'Novo Exercício']
    end

    context 'when all parameters sent are valid' do
      let(:params) {
        {
          'exercise_title' => 'test',
          'exercise_content' => 'test'
        }
      }

      it 'creates a new exercise' do
        expect{
          fill_in_form '.simple_form', params
        }.to change(Exercise,:count).by 1
      end

      it 'redirect to exercise path' do
        fill_in_form '.simple_form', params

        expect(page.current_path).to eq teacher_lo_exercise_path(lo, Exercise.last)
      end

      it 'display the exercise title' do
        fill_in_form '.simple_form', params

        expect(page).to have_content 'test'
      end
    end

    context 'when one or more parameters sent are invalid' do
      let(:params) {
        {
          'exercise_title' => nil,
          'exercise_content' => 'test'
        }
      }

      it 'does not create an exercise' do
        visit(new_teacher_lo_exercise_path(lo))

        expect{
          fill_in_form '.simple_form', params
        }.to_not change(Exercise,:count)
      end
    end
  end

  describe '#update' do
    before { visit(edit_teacher_lo_exercise_path(lo, exercise)) }

    it 'display breadcrumbs' do
      expect(breadcrumbs).to eq ['Início', 'Meus OAs', "OA #{lo.name}", 'Editar Exercício']
    end

    context 'when all parameters sent are valid' do
      let(:params) {
        {
          'exercise_title' => 'test',
          'exercise_content' => 'test'
        }
      }

      it 'updates the exercise' do
        fill_in_form '.simple_form', params

        exercise.reload

        expect(exercise.as_json).to include({'title' => 'test', 'content' => 'test'})
      end

      it 'redirect to exercise path' do
        fill_in_form '.simple_form', params

        expect(page.current_path).to eq teacher_lo_exercise_path(lo, exercise)
      end

      it 'display the exercise title' do
        fill_in_form '.simple_form', params

        expect(page).to have_content 'test'
      end
    end

    context 'when one or more parameters sent are invalid' do
      let(:params) {
        {
          'exercise_title' => nil,
          'exercise_content' => 'test'
        }
      }

      it 'does not updates the exercise' do
        fill_in_form '.simple_form', params
        exercise.reload

        expect(exercise.as_json).to_not include({'title' => 'test', 'content' => 'test'})
      end
    end
  end

  describe '#delete' do
    it 'deletes the exercise' do
      page.driver.submit :delete, teacher_lo_exercise_path(lo, exercise), {}

      expect(Exercise).to_not be_exists(exercise.id)
    end
  end
end
