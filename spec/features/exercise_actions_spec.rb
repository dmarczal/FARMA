require 'rails_helper'

describe 'Exercise features' do
  let(:user) { create(:user, :actived) }
  let(:lo) { create(:lo, user: user) }
  let(:exercise) { create(:exercise, lo: lo) }

  before { sign_in user }

  describe '#show' do
    it 'display the correct' do
      visit(teacher_lo_exercise_path(lo, exercise))

      expect(page).to have_content truncate("Questões do exercicio #{exercise.title}", length: 25)
    end
  end

  describe '#new' do
    it 'display the "New Exercise"' do
      visit(new_teacher_lo_exercise_path(lo))

      expect(page).to have_content 'Novo Exercício'
    end
  end

  describe '#edit' do  
    it 'display the "Edit Exercise"' do
      visit(edit_teacher_lo_exercise_path(lo, exercise))

      expect(page).to have_content truncate("Editar Exercício", length: 25)
    end
  end

  describe '#create' do
    context 'when all parameters sent are valid' do
      let(:params) { 
        {
          'exercise_title' => 'test',
          'exercise_content' => 'test'
        }
      }

      it 'creates a new exercise' do
        visit(new_teacher_lo_exercise_path(lo))

        expect{
          fill_in_form '.simple_form', params
        }.to change(Exercise,:count).by 1
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
